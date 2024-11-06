import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/user_model.dart';

class LoginWithEmail {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Constants for secure storage keys
  static const String authTokenKey = 'auth_token';

  // Create document for the user
  Future<void> createUserDocument(User? user) async {
    if (user == null) return;

    final userDoc = _firestore.collection('users').doc(user.uid);
    if (!(await userDoc.get()).exists) {
      await userDoc.set({
        'username': user.email?.split('@')[0] ?? '',
        'email': user.email,
        'phone': '',
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

  // Sign in with email and password
  Future<UserModel?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save token to secure storage
      String? idToken = await userCredential.user?.getIdToken();
      if (idToken != null) {
        await _storage.write(key: authTokenKey, value: idToken);
      }

      // Retrieve user data from Firestore
      return await _getUserModel(userCredential.user);

    } catch (e) {
      print('Error signing in: $e');
      return null; // Return null if an error occurs
    }
  }

  // Helper method to get UserModel from Firestore
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
      await createUserDocument(user);
      return await _getUserModel(user); // Re-fetch after creating the user document
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    await _storage.delete(key: authTokenKey);
  }

  // Get the current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Get the ID token from secure storage
  Future<String?> getIdToken() async {
    User? user = getCurrentUser();
    if (user != null) {
      String? token = await _storage.read(key: authTokenKey);
      if (token == null) {
        token = await user.getIdToken(); // Retrieve new token if not available
        await _storage.write(key: authTokenKey, value: token);
      }
      return token;
    }
    return null; // No user is signed in
  }
}
