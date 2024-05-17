
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:hospital_managements/Connection/connection.dart';

import 'admin/admin_home.dart';
import 'doctor/doctor_home.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConnectionLogin(),
    );
  }
}

void main() {

 runApp(MyApp());
 doWhenWindowReady(() {
   var initialSize = Size(1140, 900);
   appWindow.size = initialSize;
   appWindow.minSize = initialSize;
 });
}