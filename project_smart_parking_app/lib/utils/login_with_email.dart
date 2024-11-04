import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginWithEmail {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  // Sign in with email and password
  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Lưu token vào secure storage
      String? idToken = await userCredential.user?.getIdToken();
      if (idToken != null) {
        await _storage.write(key: 'auth_token', value: idToken);
      }

      return userCredential.user; // Return the logged-in user
    } catch (e) {
      print('Error signing in: $e');
      return null; // Return null if an error occurs
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    // Xóa token khỏi secure storage khi đăng xuất
    await _storage.delete(key: 'auth_token');
  }

  // Get the current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Get the ID token from secure storage
  Future<String?> getIdToken() async {
    User? user = getCurrentUser();
    if (user != null) {
      String? token = await _storage.read(key: 'auth_token');
      if (token == null) {
        token = await user.getIdToken(); // Nếu không có token, lấy token mới
        await _storage.write(key: 'auth_token', value: token);
      }
      return token;
    }
    return null; // No user is signed in
  }
}
