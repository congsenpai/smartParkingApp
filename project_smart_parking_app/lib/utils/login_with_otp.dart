import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class LoginWithOTP {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserProvider _userProvider = UserProvider();
  String _verificationId = '';

  // Tạo tài liệu người dùng trong Firestore nếu chưa tồn tại
  Future<void> _createUserDocument(User? user) async {
    if (user == null) return;

    final userDoc = _firestore.collection('users').doc(user.uid);
    if (!(await userDoc.get()).exists) {
      await userDoc.set({
        'username': user.phoneNumber ?? '',
        'email': '',
        'phone': user.phoneNumber,
        'userImg': '',
        'userDeviceToken': '',
        'country': '',
        'userAddress': '',
        'isAdmin': false,
        'isActive': true,
        'createdOn': DateTime.now(),
        'city': '',
        'vehical': [],
      });
    }
  }

  // Lấy thông tin người dùng từ Firestore và tạo UserModel
  Future<UserModel?> _getUserModel(User? user) async {
    if (user == null) return null;

    DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();

    if (userDoc.exists) {
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      return UserModel(
        uId: user.uid,
        username: userData['username'] ?? '',
        email: userData['email'] ?? '',
        phone: userData['phone'] ?? '',
        userImg: userData['userImg'] ?? '',
        userDeviceToken: userData['userDeviceToken'] ?? '',
        country: userData['country'] ?? '',
        userAddress: userData['userAddress'] ?? '',
        isAdmin: userData['isAdmin'] ?? false,
        isActive: userData['isActive'] ?? true,
        createdOn: userData['createdOn'] ?? DateTime.now(),
        city: userData['city'] ?? '',
        vehical: List<Map<String, String>>.from(userData['vehical'] ?? []),
      );
    } else {
      print('User document does not exist, creating a new one.');
      await _createUserDocument(user);
      return await _getUserModel(user); // Re-fetch after creating the user document
    }
  }

  // Gửi OTP đến số điện thoại
  Future<void> sendOtp(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          print('Số điện thoại đã xác thực tự động và người dùng đã đăng nhập');

          UserModel? model = await _getUserModel(_auth.currentUser);
          if (model != null) {
            await _userProvider.login(model); // Lưu vào UserProvider
          }
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

  // Xác thực OTP và lưu UserModel vào UserProvider
  Future<UserModel?> verifyOtp(String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otp,
      );
      UserCredential userCredential = await _auth.signInWithCredential(credential);

      // Tạo hoặc lấy UserModel từ Firestore
      UserModel? model = await _getUserModel(userCredential.user);
      if (model != null) {
        await _userProvider.login(model); // Lưu vào UserProvider
      }
      print('Người dùng đã đăng nhập thành công!');
      return model;
    } catch (e) {
      print('Lỗi khi xác thực OTP: $e');
      return null;
    }
  }

  // Đăng xuất
  Future<void> signOut() async {
    await _auth.signOut();
    await _userProvider.logout(); // Đăng xuất khỏi UserProvider
  }

  // Lấy người dùng hiện tại
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
