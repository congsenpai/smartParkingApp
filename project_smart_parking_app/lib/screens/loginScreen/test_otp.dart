import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  _PhoneLoginScreenState createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  String _verificationId = '';
  bool _otpSent = false;

  // Gửi OTP đến số điện thoại
  void _sendOTP() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: _phoneController.text,
        timeout: const Duration(seconds: 60),
        // xác thực người dùng mà ko cần OTP do đ đăng nhập trước đó
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Số điện thoại đã xác thực tự động và người dùng đã đăng nhập'),
          )
          );
          },
        verificationFailed: (FirebaseAuthException e) {
          print('Xác thực thất bại: ${e.message}');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Lỗi xác thực: ${e.message}'),
          ));
          },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
            _otpSent = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Đã gửi mã OTP đến sdt: ${_phoneController.text}'),
          ));
          },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
          },
      );
    }
    catch (e) {
      print('Lỗi khi gửi OTP: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Lỗi khi gửi OTP: $e'),
      ));
    }}

  // Xác thực OTP
  void _verifyOTP() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _otpController.text,
      );
      await _auth.signInWithCredential(credential);
      print('Người dùng đã đăng nhập thành công!');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Đăng nhập thành công!'),
      ));
    } catch (e) {
      print('Lỗi khi xác thực OTP: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Lỗi xác thực OTP: $e'),
      ));
    }
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
            if (_otpSent) // Hiển thị ô nhập OTP nếu đã gửi mã
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
              onPressed: _otpSent ? _verifyOTP : _sendOTP,
              child: Text(_otpSent ? 'Xác thực OTP' : 'Gửi mã OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
