import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'BluetoothDeviceListEntry.dart';

// import 'bluetooth_controller.dart';

class NewTestPage extends StatefulWidget {
  const NewTestPage({super.key});

  @override
  State<NewTestPage> createState() => _NewTestPageState();
}

class _NewTestPageState extends State<NewTestPage> {
  // BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  // List<BluetoothDevice> devices = List<BluetoothDevice>.empty();

  // @override
  // void initState(){
  //   super.initState();
  //   _getBTState();
  //   _stateChangeListener();
  //   _listBondedDevices();
  // }

  //   _getBTState(){
  //   FlutterBluetoothSerial.instance.state.then((state){
  //     _bluetoothState = state;
  //     setState((){});
  //   });
  // }

  // _stateChangeListener(){
  //   FlutterBluetoothSerial.instance
  //   .onStateChanged()
  //   .listen((BluetoothState state){
  //     _bluetoothState = state;
  //     print("State isEnabled: ${state.isEnabled}");
  //     setState(() {});
  //   });
  // }

  // _listBondedDevices(){
  //   FlutterBluetoothSerial.instance.getBondedDevices().then((List<BluetoothDevice> bondedDevices){
  //     devices = bondedDevices;
  //     setState(() {});
  //   });
  // }




  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _reason = '';
  String _address = '';
  DateTime _date = DateTime.now();
  // final FlutterBlue flutterBlue = FlutterBlue.instance;
  // List<BluetoothDevice> _devicesList = [];
  // BluetoothDevice? _selectedDevice;
  // bool _isScanning = false;
  // Timer? _timer;

 

  
  // void scanForDevices() async {
  //   if (_isScanning) return; // Prevent multiple scans

  //   setState(() {
  //     _isScanning = true;
  //     _devicesList.clear();
  //   });

  //   await flutterBlue.startScan(
  //     withServices: [Guid("180D")], // match any of the specified services
  //     //withNames: ["Bluno"], // *or* any of the specified names
  //     timeout: const Duration(seconds: 30), // Increase the timeout
  //   ).then((_) {
  //     setState(() {
  //       _isScanning = false;
  //     });
  //     _timer?.cancel(); // Cancel the periodic timer when the scan completes
  //   });

  //   flutterBlue.scanResults.listen((results) {
  //     setState(() {
  //       for (ScanResult r in results) {
  //         if (!_devicesList.contains(r.device)) {
  //           _devicesList.add(r.device);
  //         }
  //       }
  //     });
  //   });

  //   _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
  //     _printScanResults();
  //   });

  //   // Stop the timer when the scan stops
  //   Future.delayed(const Duration(seconds: 30)).then((_) {
  //     _timer?.cancel();
  //   });
  // }

  // void _printScanResults() {
  //   print('Scan Results:');
  //   for (var device in _devicesList) {
  //     print('${device.name} found id: ${device.id}');
  //   }
  // }

  // _showBluetoothDevicesDialog() {
  //   return AlertDialog(
  //     content: GetBuilder<BleController>(
  //       init: BleController(),
  //       builder: (BleController controller){
  //         return Center(
  //           child:Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 StreamBuilder<List<ScanResult>>(
  //                   stream: controller.scanResults,
  //                   builder : (context,snapshot){
  //                     if(snapshot.hasData){
  //                       return ListView.builder(
  //                         itemBuilder: (context, index){
  //                           final data = snapshot.data![index];
  //                           return Card(
  //                             elevation : 2 ,
  //                             child: ListTile(
  //                               title: Text(data.device.name),
  //                               subtitle: Text(data.device.id.id),
  //                               trailing: Text(data.rssi.toString()),
  //                             )
  //                           );
  //                         },
  //                       );
  //                     }else{
  //                       return Center(child: Text("No Devices Found"),);
  //                     }
  //                   }
  //                 ),
  //                 SizedBox(height: 10.0,),
  //                 ElevatedButton(onPressed: ()=>controller.scanDevices(), child: Text("SCAN"))
  //               ],
  //             ),
  //           );
  //       }
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        shadowColor: Colors.black,
        title: const Text(
          "New Test",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 5.5,
        actions: [
          IconButton(
            onPressed: () => GoRouter.of(context).go('view_all_previous_tests'),
            icon: const Icon(Icons.science_outlined),
          ),
          IconButton(
            onPressed: () => {} ,
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 4) {
            setState(() {
              _currentStep += 1;
            });
          } else {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              GoRouter.of(context).go('waiting_screen');
            }
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep -= 1;
            });
          }
        },
        steps: [
          Step(
            title: const Text('Power on the Device'),
            content: const Text('Press the power button on the device to turn it on.'),
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Connect to the Device'),
            content: Column(
              children: [
                const Text('Turn on Bluetooth and connect to the device. The device name is CHOLERA_ALERT_DEVICE.'),
                ElevatedButton(
                  onPressed : ()=> GoRouter.of(context).go('/bluetooth_scan'),
                  child: const Text('Connect to Device'),
                ),
              ],
            ),
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Prepare Water Sample'),
            content: const Text('Add the water sample to the device and press the button to start the test.'),
            isActive: _currentStep >= 2,
            state: _currentStep > 2 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Fill in the Form'),
            content: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        _name = value;
                      }
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Reason for Test'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the reason for the test';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        _reason = value;
                      }
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Address'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        _address = value;
                      }
                    },
                  ),
                  SizedBox(height: 30.0),
                  InputDatePickerFormField(
                    fieldLabelText: 'Date',
                    initialDate: _date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    onDateSaved: (value) {
                      _date = value;
                    },
                  ),
                ],
              ),
            ),
            isActive: _currentStep >= 3,
            state: _currentStep > 3 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Wait for Test to Complete'),
            content: const Text('The test will take approximately 30 minutes. Please wait.'),
            isActive: _currentStep >= 4,
            state: _currentStep > 4 ? StepState.complete : StepState.indexed,
          ),
        ],
      ),
    );
  }
}