// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:project_smart_parking_app/models/user_model.dart';
import 'package:project_smart_parking_app/utils/login_with_otp.dart';
import '../home_screen.dart';

class OtpScreen extends StatelessWidget {
  final String phoneNumber;

  const OtpScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E19),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: Get.height / 26),
                Padding(
                  padding: EdgeInsets.only(top: Get.height / 30),
                  child: Image.asset('assets/images/logo.png', height: 60),
                ),
                SizedBox(height: Get.height / 12),
                Center(
                  child: CircleAvatar(
                    radius: Get.width / 8,
                    child: const Icon(
                      Icons.verified_user_rounded,
                      size: 60,
                    ),
                  ),
                ),
                const Text(
                  'Nguyen Duc Cong',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Get.height / 24),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "We've sent unique OTP to ",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: phoneNumber,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text: '\nto confirm your real identity now',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height / 18),
                OTPInputRow(
                  phoneNumber: phoneNumber,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OTPInputRow extends StatefulWidget {
  final String phoneNumber;

  const OTPInputRow({super.key, required this.phoneNumber});

  @override
  OTPInputRowState createState() => OTPInputRowState();
}

class OTPInputRowState extends State<OTPInputRow> {
  DateTime? _lastOtpSentTime;

  DateTime? get lastOtpSentTime => _lastOtpSentTime;
  final LoginWithOTP _loginWithOTP = LoginWithOTP();
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
    // Gửi OTP khi trang được khởi tạo
    _loginWithOTP.sendOtp(widget.phoneNumber).then((_) async {
      EasyLoading.show(status: 'Sending OTP...');
      await Future.delayed(const Duration(seconds: 5));
      EasyLoading.dismiss();
    });
    setLastOtpSentTime(DateTime.now());
  }

  void setLastOtpSentTime(DateTime time) {
    _lastOtpSentTime = time;
  }

  void _showResendOtpSnackbar(BuildContext context) {
    int remainingSeconds =
        30 - DateTime.now().difference(_lastOtpSentTime!).inSeconds;

    // Ensure remainingSeconds is not negative
    remainingSeconds = remainingSeconds.clamp(0, 30);

    final snackBar = SnackBar(
      content:
          Text('You can only resend the OTP after $remainingSeconds seconds'),
      duration: Duration(
          seconds: remainingSeconds + 1), // Show for remaining time + 1 second
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    // Add a delay before hiding the current snackbar (for example, 1 second delay)
    Future.delayed(const Duration(seconds: 1), () {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    });
  }

  bool canResendOtp() {
    if (_lastOtpSentTime == null ||
        DateTime.now().difference(_lastOtpSentTime!).inSeconds > 30) {
      return true;
    } else {
      _showResendOtpSnackbar(context); // Show snackbar if notallowed
      return false;
    }
  }

  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String getOtp() {
    return _controllers.map((controller) => controller.text).join('');
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Lỗi'),
          content: const Text('Mã OTP không hợp lệ. Vui lòng thử lại.'),
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

  void _login() async {
    String otp = getOtp();
    print(otp);
    UserModel? user = await _loginWithOTP.verifyOtp(otp);
    if (user != null) {
      print('Login successful: ${user.username}');
      EasyLoading.show(status: 'Verifying...');
      await Future.delayed(const Duration(seconds: 3));
      EasyLoading.dismiss();
      Get.to(HomeScreen());
    } else {
      _showErrorDialog();
      print('Login failed. Please check your credentials.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
              child: TextField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 30, color: Colors.white),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: (value) {
                  if (value.isEmpty && index > 0) {
                    FocusScope.of(context).previousFocus();
                  } else if (value.length == 1) {
                    if (index < 5) {
                      FocusScope.of(context).nextFocus();
                    } else {
                      FocusScope.of(context).unfocus();
                    }
                  }
                },
              ),
            );
          }),
        ),
        SizedBox(
          height: Get.height / 28,
        ),
        TextButton(
          onPressed: () {
            if (canResendOtp()) {
              setState(() {
                for (var controller in _controllers) {
                  controller.clear();
                }
              });
              _loginWithOTP.sendOtp(widget.phoneNumber).then((_) async {
                EasyLoading.show(status: 'Sending OTP...');
                await Future.delayed(const Duration(seconds: 5));
                EasyLoading.dismiss();
              });
            } else {}
          },
          child: const Text(
            'Resend OTP Code',
            style: TextStyle(color: Colors.blueAccent, fontSize: 18),
          ),
        ),
        SizedBox(height: Get.height / 20),
        if (getOtp().length == 6)
          ElevatedButton(
            onPressed: _login,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4040FD),
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Verify',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
      ],
    );
  }
}
