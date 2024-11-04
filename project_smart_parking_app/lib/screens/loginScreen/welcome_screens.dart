import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_smart_parking_app/screens/loginScreen/login_screen.dart';
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
              'Get Your\n    Secure Park',
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                fontFamily: 'Roboto',
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'We provide thousands safe places for\nyour beautiful and luxury cars',
              style: TextStyle(
                color: Colors.white60,
                fontSize: 16,
                decoration: TextDecoration.none,
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Change to the WelcomeScreen1
                  Get.to(const LoginScreen());
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

