import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:project_smart_parking_app/screens/BookingScreent/parkingBookingScreen.dart';
import 'package:project_smart_parking_app/screens/home_screen.dart';
import 'package:project_smart_parking_app/test/slotTestScreen.dart';
import 'package:project_smart_parking_app/screens/loginScreen/welcome_screens.dart';
import 'package:project_smart_parking_app/screens/orderScreen/MainOrderScreen.dart';
import 'package:project_smart_parking_app/utils/login_with_email.dart';
import 'package:project_smart_parking_app/widgets/MapGGWidget.dart';
import 'Language/language.dart';

// import 'package:project_smart_parking_app/screens/parking_order_screen.dart';
// import 'package:project_smart_parking_app/screens/loginScreen/welcome_screens.dart';

void main() async {

  LanguageSelector languageSelector = LanguageSelector();
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
  LoginWithEmail loginWithEmail = LoginWithEmail();
  // Check if a user is already signed in
  User? currentUser = loginWithEmail.getCurrentUser();
  if (currentUser != null) {
    // User is already signed in
    print('User is signed in: ${currentUser.email}');

    // Get the ID token from secure storage
    String? token = await loginWithEmail.getIdToken();
    print('ID Token: $token');

    runApp(const MyAppLoggedIn());
  } else {
    runApp(const MyAppNormal());
  }

}
class MyAppNormal extends StatefulWidget {
  const MyAppNormal({super.key});

  @override
  State<MyAppNormal> createState() => _MyAppState();
}

class _MyAppState extends State<MyAppNormal> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder:EasyLoading.init(),
      home: WelcomeScreen()
    );
  }
}
class MyAppLoggedIn extends StatefulWidget {
  const MyAppLoggedIn({super.key});

  @override
  _MyAppLoggedInState createState() => _MyAppLoggedInState();
}

class _MyAppLoggedInState extends State<MyAppLoggedIn> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        builder:EasyLoading.init(),
        home: HomeScreen()
    );
  }
}
