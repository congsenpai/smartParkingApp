// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_auth_provider/flutter_auth_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import '../utils/login_with_email.dart'; // Import this for JSON encoding/decoding

// UserModel class definition
class UserModel {
  final String uId;
  final String username;
  final String email;
  final String phone;
  final String userImg;
  final String userDeviceToken;
  final String country;
  final String userAddress;
  final bool isAdmin;
  final bool isActive;
  final dynamic createdOn;
  final String city;
  final List<Map<String, String>> vehical;

  UserModel({
    required this.vehical,
    required this.uId,
    required this.username,
    required this.email,
    required this.phone,
    required this.userImg,
    required this.userDeviceToken,
    required this.country,
    required this.userAddress,
    required this.isAdmin,
    required this.isActive,
    required this.createdOn,
    required this.city,
  });

  // Convert to Map for JSON encoding
  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'username': username,
      'email': email,
      'phone': phone,
      'userImg': userImg,
      'userDeviceToken': userDeviceToken,
      'country': country,
      'userAddress': userAddress,
      'isAdmin': isAdmin,
      'isActive': isActive,
      'createdOn': createdOn,
      'city': city,
      'vehical': vehical,
    };
  }

  // Create UserModel from Map (JSON)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      vehical: List<Map<String, String>>.from(
        (json['vehical'] as List<dynamic>).map(
              (e) => Map<String, String>.from(e as Map),
        ),
      ),
      uId: json['uId'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      userImg: json['userImg'],
      userDeviceToken: json['userDeviceToken'],
      country: json['country'],
      userAddress: json['userAddress'],
      isAdmin: json['isAdmin'],
      isActive: json['isActive'],
      createdOn: json['createdOn'],
      city: json['city'],
    );
  }
}

// Storage keys
const String userIdKey = 'uId';
const String usernameKey = 'username';
const String emailKey = 'email';
const String phoneKey = 'phone';
const String userImgKey = 'userImg';
const String userDeviceTokenKey = 'userDeviceToken';
const String countryKey = 'country';
const String userAddressKey = 'userAddress';
const String isAdminKey = 'isAdmin';
const String isActiveKey = 'isActive';
const String createdOnKey = 'createdOn';
const String cityKey = 'city';
const String vehicalKey = 'vehical';
const String tokenKey = 'token';
const String refreshTokenKey = 'refreshToken';

class SecureStore implements AuthStore<UserModel>, TokenStore {
  static final SecureStore _instance = const SecureStore._();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  const SecureStore._();

  factory SecureStore() => _instance;

  @override
  Future<void> delete() async {
    await _storage.delete(key: userIdKey);
    await _storage.delete(key: usernameKey);
    await _storage.delete(key: emailKey);
    await _storage.delete(key: phoneKey);
    await _storage.delete(key: userImgKey);
    await _storage.delete(key: userDeviceTokenKey);
    await _storage.delete(key: countryKey);
    await _storage.delete(key: userAddressKey);
    await _storage.delete(key: isAdminKey);
    await _storage.delete(key: isActiveKey);
    await _storage.delete(key: createdOnKey);
    await _storage.delete(key: cityKey);
    await _storage.delete(key: vehicalKey);
  }

  @override
  Future<UserModel?> retrieve() async {
    final uId = await _storage.read(key: userIdKey);
    final username = await _storage.read(key: usernameKey);
    final email = await _storage.read(key: emailKey);
    final phone = await _storage.read(key: phoneKey);
    final userImg = await _storage.read(key: userImgKey);
    final userDeviceToken = await _storage.read(key: userDeviceTokenKey);
    final country = await _storage.read(key: countryKey);
    final userAddress = await _storage.read(key: userAddressKey);
    final isAdmin = await _storage.read(key: isAdminKey) == 'true';
    final isActive = await _storage.read(key: isActiveKey) == 'true';
    final createdOn = await _storage.read(key: createdOnKey);
    final city = await _storage.read(key: cityKey);
    final vehicalJson = await _storage.read(key: vehicalKey);

    List<Map<String, String>> vehical = [];
    if (vehicalJson != null) {
      vehical = List<Map<String, String>>.from(json.decode(vehicalJson));
    }

    if (uId != null && username != null) {
      return UserModel(
        vehical: vehical,
        uId: uId,
        username: username,
        email: email ?? '',
        phone: phone ?? '',
        userImg: userImg ?? '',
        userDeviceToken: userDeviceToken ?? '',
        country: country ?? '',
        userAddress: userAddress ?? '',
        isAdmin: isAdmin,
        isActive: isActive,
        createdOn: createdOn,
        city: city ?? '',
      );
    }
    return null;
  }

  @override
  Future<void> save(UserModel user) async {
    await _storage.write(key: userIdKey, value: user.uId);
    await _storage.write(key: usernameKey, value: user.username);
    await _storage.write(key: emailKey, value: user.email);
    await _storage.write(key: phoneKey, value: user.phone);
    await _storage.write(key: userImgKey, value: user.userImg);
    await _storage.write(key: userDeviceTokenKey, value: user.userDeviceToken);
    await _storage.write(key: countryKey, value: user.country);
    await _storage.write(key: userAddressKey, value: user.userAddress);
    await _storage.write(key: isAdminKey, value: user.isAdmin.toString());
    await _storage.write(key: isActiveKey, value: user.isActive.toString());
    await _storage.write(key: createdOnKey, value: user.createdOn.toString());
    await _storage.write(key: cityKey, value: user.city);

    // Serialize vehical list into a JSON string before saving
    await _storage.write(key: vehicalKey, value: json.encode(user.vehical));
  }

  @override
  Future<void> clear() async {
    await _storage.delete(key: tokenKey);
    await _storage.delete(key: refreshTokenKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    return _storage.read(key: refreshTokenKey);
  }

  @override
  Future<String?> getToken() async {
    return _storage.read(key: tokenKey);
  }

  @override
  Future<void> saveTokens({required String token, String? refreshToken}) async {
    await _storage.write(key: tokenKey, value: token);
    if (refreshToken != null) {
      await _storage.write(key: refreshTokenKey, value: refreshToken);
    }
  }
}

class UserProvider with ChangeNotifier {
  final SecureStore _secureStore = SecureStore();
  UserModel? _user;

  UserModel? get user => _user;

  bool get isLoggedIn => _user != null;

  // Phương thức đăng nhập
  Future<void> login(UserModel userModel) async {
    _user = userModel;
    await _secureStore.save(userModel); // Lưu thông tin người dùng vào SecureStore
    notifyListeners();
  }

  // Phương thức đăng xuất
  Future<void> logout() async {
    _user = null;
    await _secureStore.delete(); // Xóa thông tin người dùng khỏi SecureStore
    notifyListeners();
  }

  // Tải thông tin người dùng từ SecureStore
  Future<void> loadUser() async {
    _user = await _secureStore.retrieve(); // Lấy thông tin người dùng từ SecureStore
    notifyListeners();
  }
}