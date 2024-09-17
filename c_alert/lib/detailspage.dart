import 'dart:convert';
import 'dart:typed_data';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:photo_view/photo_view.dart';

class DetailPage extends StatefulWidget {
  final BluetoothDevice server;

  const DetailPage({required this.server});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  BluetoothConnection? connection;
  bool isConnecting = true;

  bool get isConnected => connection != null && connection!.isConnected;
  bool isDisconnecting = false;

  String _selectedFrameSize = '0';

  List<List<int>> chunks = <List<int>>[];
  int contentLength = 0;
  Uint8List? _bytes;

  RestartableTimer? _timer;

  @override
  void initState() {
    super.initState();
    _getBTConnection();
    _timer = RestartableTimer(Duration(seconds: 1), _drawImage);
  }

  @override
  void dispose() {
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  _getBTConnection() {
    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });
      connection!.input!.listen(_onDataReceived).onDone(() {
        if (isDisconnecting) {
          print('Disconnecting locally');
        } else {
          print('Disconnecting remotely');
        }
        if (mounted) {
          setState(() {});
        }
        Navigator.of(context).pop();
      });
    }).catchError((error) {
      Navigator.of(context).pop();
    });
  }

  _drawImage() {
    if (chunks.isEmpty || contentLength == 0) return;

    _bytes = Uint8List(contentLength);
    int offset = 0;
    for (final List<int> chunk in chunks) {
      _bytes!.setRange(offset, offset + chunk.length, chunk);
      offset += chunk.length;
    }

    setState(() {});

    // Show message (you can replace this with a custom loader if needed)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Downloaded image")),
    );

    contentLength = 0;
    chunks.clear();
  }

  void _onDataReceived(Uint8List data) {
    chunks.add(data);
    contentLength += data.length;
    _timer?.reset();
    print(data);
  }

  void _sendMessage(String text) async {
    text = text.trim();
    if (text.isNotEmpty) {
      try {
        connection?.output.add(utf8.encode(text));
        // Show loading
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Requesting...")),
        );
        await connection?.output.allSent;
      } catch (e) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: isConnecting
            ? Text('Connecting to ${widget.server.name} ...')
            : isConnected
                ? Text('Connected with ${widget.server.name}')
                : Text('Disconnected with ${widget.server.name}'),
      ),
      body: SafeArea(
        child: isConnected
            ? Column(
                children: <Widget>[
                  selectFrameSize(),
                  shotButton(),
                  photoFrame(),
                ],
              )
            : Center(
                child: Text(
                  "Connecting...",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
      ),
    );
  }

  Widget photoFrame() {
    return Expanded(
      child: Container(
        width: double.infinity,
        child: _bytes != null
            ? PhotoView(
                enableRotation: true,
                initialScale: PhotoViewComputedScale.covered,
                maxScale: PhotoViewComputedScale.covered * 2.0,
                minScale: PhotoViewComputedScale.contained * 0.8,
                imageProvider: MemoryImage(_bytes!),
              )
            : Container(),
      ),
    );
  }

  Widget shotButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(color: Colors.red),
          ),
        ),
        onPressed: () async {
          for (int i = 0; i < 4; i++) {
            _sendMessage(_selectedFrameSize);
            await Future.delayed(Duration(seconds: 10));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'TAKE A SHOT',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  Widget selectFrameSize() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'FRAMESIZE',
          hintText: 'Please choose one',
        ),
        value: _selectedFrameSize,
        onChanged: (value) {
          setState(() {
            _selectedFrameSize = value!;
          });
        },
        items: [
          DropdownMenuItem(value: "4", child: Text("1600x1200")),
          DropdownMenuItem(value: "3", child: Text("1280x1024")),
          DropdownMenuItem(value: "2", child: Text("1024x768")),
          DropdownMenuItem(value: "1", child: Text("800x600")),
          DropdownMenuItem(value: "0", child: Text("640x480")),
        ],
      ),
    );
  }
}
