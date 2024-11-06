import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class LoginWithGoogle {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserProvider _userProvider = UserProvider();

  // Tạo tài liệu người dùng trong Firestore nếu chưa có
  Future<void> _createUserDocument(User? user) async {
    if (user == null) return;

    final userDoc = _firestore.collection('users').doc(user.uid);
    if (!(await userDoc.get()).exists) {
      await userDoc.set({
        'username': user.email?.split('@')[0] ?? '',
        'email': user.email,
        'phone': '',
        'userImg': user.photoURL ?? '',
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

  // Đăng nhập với Google và lưu UserModel vào UserProvider
  Future<UserModel?> signInWithGoogle() async {
    try {
      // Google Authentication
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Firebase credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Firebase login
      UserCredential userCredential = await _auth.signInWithCredential(credential);

      // Tạo hoặc lấy UserModel từ Firestore
      UserModel? model = await _getUserModel(userCredential.user);
      if (model != null) {
        await _userProvider.login(model); // Lưu model vào UserProvider
      }
      return model; // Trả về UserModel đã đăng nhập
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  // Đăng xuất
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    await _userProvider.logout(); // Đăng xuất khỏi UserProvider
  }

  // Lấy người dùng hiện tại
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
