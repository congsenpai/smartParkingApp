import 'package:firebase_auth/firebase_auth.dart';

class LoginWithOTP{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = '';

  // Gửi OTP đến số điện thoại
  Future<void> sendOtp(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          print('Số điện thoại đã xác thực tự động và người dùng đã đăng nhập');
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Xác thực thất bại: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          print('Đã gửi mã OTP đến sdt: $phoneNumber');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      print('Lỗi khi gửi OTP: $e');
    }
  }

// Xác thực OTP
  Future<bool> verifyOtp(String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);
      print('Người dùng đã đăng nhập thành công!');
      return true;  // Return true if login is successful
    } catch (e) {
      print('Lỗi khi xác thực OTP: $e');
      return false; // Return false if there was an error
    }
  }

}
