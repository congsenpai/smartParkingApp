import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:project_smart_parking_app/screens/home_screen.dart';
import 'package:project_smart_parking_app/screens/loginScreen/welcome_screens.dart';
import 'package:provider/provider.dart';
import 'Language/language.dart';
import 'models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCNU5TcOg4mFmXTIn6bGlsO6PLzLYazmVg',
      appId: '1:758916961611:android:23781ef02fcdf25e94c4ce',
      messagingSenderId: "758916961611",
      projectId: 'smartparkingproject-5cd2f',
      storageBucket: 'smartparkingproject-5cd2f.appspot.com',
    ),
  );

  // Initialize EasyLoading here
  configLoading();

  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MyApp(),
    ),
  );
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..backgroundColor = Colors.black
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskType = EasyLoadingMaskType.clear;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Smart Parking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: EasyLoading.init(), // Initialize EasyLoading in the builder
      home: FutureBuilder<UserModel?>(
        future: SecureStore().retrieve(), // Check user information
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Show loading
          } else if (snapshot.hasData && snapshot.data != null) {
            // If user data is present, navigate to Home
            return HomeScreen();
          } else {
            // If no user data, navigate to Welcome
            return WelcomeScreen();
          }
        },
      ),
    );
  }
}
