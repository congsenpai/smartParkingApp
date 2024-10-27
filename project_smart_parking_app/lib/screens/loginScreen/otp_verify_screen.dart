import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/sayHello.dart';

String nameUser = "Nguyen Duc Cong";
String hello = getTimeBasedGreeting() + nameUser;

class OTPVerifyScreen extends StatefulWidget {
  final String phoneNumber;
  const OTPVerifyScreen({super.key, required this.phoneNumber,required this.verificationId});
  final String verificationId; // Nhận verificationId từ Firebase

  @override
  State<OTPVerifyScreen> createState() => _OTPVerifyScreenState();
}

class _OTPVerifyScreenState extends State<OTPVerifyScreen> {
  final TextEditingController otpController = TextEditingController();

  void verifyOTP() async {
    String otp = otpController.text;

    // Tạo PhoneAuthCredential từ OTP và verificationId
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: otp,
    );
    
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      print('OTP verified successfully');
    } catch (e) {
      print('Failed to verify OTP: $e');
    }
  }
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
                    Center(
                      child: Text(
                        hello,
                        style: const TextStyle(
                          fontSize: 35,
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight / 35),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4, right: 4),
                        child: Text(
                          "We will send the OTP message to ${widget.phoneNumber} and verify your account right now",
                          style: const TextStyle(
                            fontSize: 18,
                            decoration: TextDecoration.none,
                            color: Colors.white12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height / 8,
                    ),
                    // OTP code here
                    TextField(
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Enter OTP'),
                    ),
                    SizedBox(height: Get.height / 10),

                    ElevatedButton(
                      child: const Text(
                        "Resend the OTP message",
                        style: TextStyle(
                          fontSize: 18,
                          decoration: TextDecoration.none,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      onPressed: (){
                        // Action when clicking
                      },
                    ),


                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}




