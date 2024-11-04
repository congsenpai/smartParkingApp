import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:project_smart_parking_app/screens/home_screen.dart';
import 'package:project_smart_parking_app/screens/loginScreen/login_with_phone_number.dart';
import 'package:project_smart_parking_app/screens/loginScreen/welcome_screens.dart';
import 'package:project_smart_parking_app/utils/login_with_email.dart';
import 'package:project_smart_parking_app/utils/login_with_google.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isChecked = false; // Variable to hold checkbox state
  bool obscureText = true; // Variable to toggle password visibility
  String? _errorMessage;
  final LoginWithEmail _loginWithEmail = LoginWithEmail();
  final LoginWithGoogle _loginWithGoogle  = LoginWithGoogle();

  void _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    User? user = await _loginWithEmail.signInWithEmailPassword(email, password);

    if (user != null) {
      // Login successful, navigate to another screen or show a success message
      print('Login successful: ${user.email}');
      EasyLoading.show(status: 'Verifying...');
      await Future.delayed(const Duration(seconds: 3));
      EasyLoading.dismiss();
      Get.to(HomeScreen());
    } else {
      // Handle login error
      setState(() {
        _errorMessage = 'Login failed. Please check your credentials.';
      });
    }
  }
  void _loginAsGoogle() async {
    User? user = await _loginWithGoogle.signInWithGoogle();

    if (user != null) {
      // Login successful
      print('Login successful: ${user.email}');
      EasyLoading.show(status: 'Verifying...');
      await Future.delayed(const Duration(seconds: 3));
      EasyLoading.dismiss();
      Get.to(HomeScreen());
    } else {
      // Handle login error
      setState(() {
        _errorMessage = 'Login failed. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo and Title in a Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: Get.height / 15,
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height / 20,
                ),
                const Text(
                  'Sign in to Parkiin',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: Get.height / 40,
                ),

                // Email TextField
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: const Color(0xFF2C2F3F),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: Get.height / 40,
                ),

                // Password TextField with Visibility Toggle
                TextField(
                  controller: _passwordController,
                  obscureText: obscureText, // Use the obscureText variable
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: const Color(0xFF2C2F3F),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText; // Toggle the state
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: Get.height / 30,
                ),

                // Remember Me & Forgot Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value ?? false;
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                        const Text(
                          'Remember Me',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Get.snackbar(
                          'Password Recovery',
                          'Link to reset password sent to your email!',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.black54,
                          colorText: Colors.white,
                        );
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),

                // Sign In Button with GetX Navigation
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _login();
                      if(_errorMessage!=null){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Lỗi'),
                              content: Text(_errorMessage!),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white30,
                        padding: const EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2))),
                    child: const Text('Sign in',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
                SizedBox(
                  height: Get.height / 20,
                ),

                // Divider with "or"
                const Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('or', style: TextStyle(color: Colors.grey)),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),
                SizedBox(
                  height: Get.height / 40,
                ),

                // Social Sign-In Buttons
                ElevatedButton(
                  onPressed: () {
                    _loginAsGoogle();
                    if(_errorMessage!=null){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Lỗi'),
                            content: Text(_errorMessage!),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: Colors.white, width: 1),
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2))),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.g_mobiledata_rounded, color: Colors.white),
                      Text('Sign in with google',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.normal,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height / 40,
                ),

                // Social Sign-In Buttons
                ElevatedButton(
                  onPressed: () {
                    // Handle phone sign in
                    Get.to(const LoginWithPhoneNumberScreen());
                  },
                  style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: Colors.white, width: 1),
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2))),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone, color: Colors.white),
                      Text(
                        'Sign in with phone number',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height / 40,
                ),

                // Sign Up Prompt
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'New to Parkiin?',
                      style: TextStyle(color: Colors.white70),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to Sign Up Screen
                      },
                      child: const Text(
                        'Create new account here →',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
