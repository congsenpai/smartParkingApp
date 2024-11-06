import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'otp_screen.dart';

class LoginWithPhoneNumberScreen extends StatefulWidget {
  const LoginWithPhoneNumberScreen({super.key});

  @override
  State<LoginWithPhoneNumberScreen> createState() => _WelcomeScreens1State();
}

class _WelcomeScreens1State extends State<LoginWithPhoneNumberScreen> {
  String phoneNumber = '';
  bool isValidPhoneNumber = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF070201),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: constraints.maxHeight / 30),
                      Center(
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: Get.width / 2.2,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight / 12),
                      Center(
                        child: CircleAvatar(
                          radius: Get.width / 6,
                          child: const Icon(
                            Icons.verified_user_rounded,
                            size: 60,
                          ),
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight / 45),
                      const Center(
                        child: Text(
                          "Verify Account",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 35,
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight / 35),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 4, right: 4),
                          child: Text(
                            "We will send the OTP message to your phone number and verify your account right now",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 18,
                              decoration: TextDecoration.none,
                              color: Colors.white30,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height / 8,
                      ),
                      IntlPhoneField(
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        initialCountryCode: 'VN',
                        dropdownTextStyle: const TextStyle(color: Colors.white),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        validator: (phone) {
                          if (phone == null || phone.number.length != 11) {
                            return 'Input is not a valid phone number';
                          } else {
                            setState(() {
                              phoneNumber = '+${phone.number}';
                              isValidPhoneNumber = true;
                            });
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: Get.height / 10),
                      isValidPhoneNumber
                          ? ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OtpScreen(
                                      phoneNumber: phoneNumber)));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4040FD),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Get the OTP code',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                          : SizedBox(height: Get.height / 10),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
