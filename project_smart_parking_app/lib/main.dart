import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_smart_parking_app/screens/detail_parking_screent.dart';
import 'package:project_smart_parking_app/screens/home_screent.dart';
import 'package:project_smart_parking_app/screens/parking_order_screent.dart';
import 'package:project_smart_parking_app/screens/welcome_screens.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: ParkingScreen(),
    );
  }
}





