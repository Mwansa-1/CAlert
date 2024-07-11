// import 'package:flutter/material.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// import 'BluetoothDeviceListEntry.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {

//   BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

//   List<BluetoothDevice> devices = List<BluetoothDevice>.empty();

//   @override
//   void initState(){
//     super.initState();
//     _getBTState();
//     _stateChangeListener();
//     _listBondedDevices();
//   }

//   _getBTState(){
//     FlutterBluetoothSerial.instance.state.then((state){
//       _bluetoothState = state;
//       setState((){});
//     });
//   }

//   _stateChangeListener(){
//     FlutterBluetoothSerial.instance
//     .onStateChanged()
//     .listen((BluetoothState state){
//       _bluetoothState = state;
//       print("State isEnabled: ${state.isEnabled}");
//       setState(() {});
//     });
//   }

//   _listBondedDevices(){
//     FlutterBluetoothSerial.instance.getBondedDevices().then((List<BluetoothDevice> bondedDevices){
//       devices = bondedDevices;
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home"),
//       ),

//       body: Container(
//         child: Column(
//           children: <Widget>[
//             SwitchListTile(
//               title: Text('Enable Bluetooth'),
//               value: _bluetoothState.isEnabled,
//               onChanged:(bool value){
//                 future() async{
//                   if (value){
//                     await FlutterBluetoothSerial.instance.requestEnable();
//                   }else{
//                     await FlutterBluetoothSerial.instance.requestDisable();
//                   }
//                   future().then((_){
//                     setState((){});
//                   });
//                 }
//               } ,
//             ),
//             ListTile(
//               title: Text("Bluetooth Status"),
//               subtitle: Text(_bluetoothState.toString()),
//               trailing: TextButton(
//                 child: Text("Settings"),
//                 onPressed: (){
//                   FlutterBluetoothSerial.instance.openSettings();
//                 },

//               ),
//             ),
//             Expanded(
//               child: ListView(
//                 children: devices.map((_device)=>BluetoothDeviceListEntry(
//                   device: _device,
//                   enabled: true,
//                   onTap: (){
//                     print("Item");
//                   },

//                 ))
//                 .toList(),
//               )
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }