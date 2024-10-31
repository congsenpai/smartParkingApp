import 'package:flutter/material.dart';
import 'package:project_smart_parking_app/utils/LoginWithOTP.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  _PhoneLoginScreenState createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final LoginWithOTP _authService = LoginWithOTP();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _otpSent = false;

  void _sendOtp() async {
    await _authService.sendOtp(_phoneController.text);
    setState(() {
      _otpSent = true;
    });
  }

  void _verifyOtp() async {
    await _authService.verifyOtp(_otpController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng nhập bằng OTP')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Số điện thoại',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),
            if (_otpSent)
              TextField(
                controller: _otpController,
                decoration: const InputDecoration(
                  labelText: 'Nhập mã OTP',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _otpSent ? _verifyOtp : _sendOtp,
              child: Text(_otpSent ? 'Xác thực OTP' : 'Gửi mã OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
