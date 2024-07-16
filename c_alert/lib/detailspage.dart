import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:go_router/go_router.dart';

class DetailPage extends StatefulWidget {
  final BluetoothDevice server;

  const DetailPage({required this.server});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  BluetoothConnection? connection;
  bool isConnecting = true;
  bool get isConnected => connection != null && connection!.isConnected;
  bool isDisconnecting = false;
  late Timer _connectionTimeoutTimer;

  String _selectFrameSize = '1';

  List<List<int>> chunks = <List<int>>[];
  int contentLength = 0;
  late Uint8List _bytes;


  @override
  void initState() {
    super.initState();
    _getBTConnection();
    _selectFrameSize;
  }

  @override
  void dispose() {
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
    }
    _connectionTimeoutTimer.cancel();
    super.dispose();
  }

  void _getBTConnection() {
    print('Attempting to connect to ${widget.server.address}');
    
    // Start a timer to handle connection timeout
    _connectionTimeoutTimer = Timer(Duration(seconds: 15), () {
      if (isConnecting) {
        print('Connection timed out');
        setState(() {
          isConnecting = false;
        });
        GoRouter.of(context).go('/bluetooth_scan');
      }
    });

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      isConnecting = false;
      isDisconnecting = false;
      setState(() {});
      _connectionTimeoutTimer.cancel();  // Cancel the timeout timer on successful connection
      connection!.input?.listen(_onDataReceived).onDone(() {
        if (isDisconnecting) {
          print("Disconnecting locally");
        } else {
          print("Disconnected remotely");
        }
        if (this.mounted) {
          setState(() {});
        }
        GoRouter.of(context).go('/bluetooth_scan');
      });
    }).catchError((error) {
      print('Cannot connect, exception occurred: $error');
      setState(() {
        isConnecting = false;
      });
      _connectionTimeoutTimer.cancel();  // Cancel the timeout timer on failure
      GoRouter.of(context).go('/bluetooth_scan');
    });
  }

  void _onDataReceived(Uint8List data) {
    if(data != null && data.length > 0){
      chunks.add(data);
      contentLength += data.length;
    }
    // Handle the received data
    print('Data received: $data , chunks: ${chunks.length}');
  }

  void _sendMessage(String text) async{
    text = text.trim();
    if(text.length > 0){
      try{
        connection?.output.add(utf8.encode(text));
      }catch(e){
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isConnecting
            ? Text("Connecting to ${widget.server.name}...")
            : isConnected
                ? Text("Connected with ${widget.server.name}...")
                : Text("Disconnected with ${widget.server.name}"),
      ),
      body: SafeArea(
        child: isConnected
            ? Column(
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      _sendMessage(_selectFrameSize);
                    },
                    child: Text("Take a shot"),
                  ),
                ],
              )
            : Center(
                child: Text("Connecting..."),
              ),
      ),
    );
  }
}
