import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SmartParkingApp extends StatelessWidget {
  const SmartParkingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: WelcomeScreen(),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF070201), // Dark background color
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Center(
                child: Image.asset(
              'assets/images/logo.png',
              width: Get.width / 2.2,
              fit: BoxFit.cover,
            )),
            const Spacer(),
            Center(
              child: Image.asset('assets/images/kawasaki.png'),
            ),
            const Spacer(),
            const Text(
              'Get Your\nSecure Park',
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'We provide thousands safe places for\nyour beautiful and luxury cars',
              style: TextStyle(
                color: Colors.white60,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Change to the WelcomeScreen1
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WelcomeScreens1()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4040FD), // Button color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeScreens1 extends StatefulWidget {
  const WelcomeScreens1({super.key});

  @override
  State<WelcomeScreens1> createState() => _WelcomeScreens1State();
}

class _WelcomeScreens1State extends State<WelcomeScreens1> {
  String phoneNumber = '';

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
              return
                SingleChildScrollView(
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
                              fontSize: 18,
                              decoration: TextDecoration.none,
                              color: Colors.white12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height/8,),
                      IntlPhoneField(
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        initialCountryCode: 'US', // Đặt mã quốc gia mặc định
                        onChanged: (phone) {
                          setState(() {
                            phoneNumber = phone.completeNumber;
                          });
                        },
                      ),
                      SizedBox(height: Get.height/10),
                      ElevatedButton(
                        onPressed: () {
                          // triggered event when clicking
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
                      ),
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
