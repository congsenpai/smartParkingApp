import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_smart_parking_app/screens/orderScreent/parkingSpotScreen.dart';
import 'package:project_smart_parking_app/screens/orderScreent/detail_booking.dart';
import 'package:project_smart_parking_app/screens/home_screen.dart';
import 'package:project_smart_parking_app/screens/orderScreent/parking_order_screen.dart';
// import 'package:project_smart_parking_app/screens/loginScreen/welcome_screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyCNU5TcOg4mFmXTIn6bGlsO6PLzLYazmVg',
        appId: '1:758916961611:android:23781ef02fcdf25e94c4ce',
        messagingSenderId: "758916961611",
        projectId: 'smartparkingproject-5cd2f',
        storageBucket: 'smartparkingproject-5cd2f.appspot.com',
      )
  );
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
