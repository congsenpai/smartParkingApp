import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E19), // Dark background color
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo and title
              const SizedBox(height: 20),
              Image.asset('assets/images/logo.png', height: 60),
              // Replace with your logo path
              // SizedBox(height: Get.height / 12),
              const SizedBox(height: 40),
              Center(
                child: CircleAvatar(
                  radius: Get.width / 8,
                  child: const Icon(
                    Icons.verified_user_rounded,
                    size: 60,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Good morning!',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Nguyen Duc Cong',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "We've sent unique OTP to 628 3940 2001\nto confirm your real identity now",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 20),

              // OTP input fields (using a Row with dummy values)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        '8', // Placeholder for OTP digits
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 10),

              // Resend OTP link
              TextButton(
                onPressed: () {
                  // Resend OTP logic here
                },
                child: const Text(
                  'Resend OTP Code',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Verify Button
              ElevatedButton(
                onPressed: () {
                  // Verify OTP logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B3B98), // Button color
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Verify Now',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
