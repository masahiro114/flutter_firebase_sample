import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './../../models/user_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ユーザー登録
  Future<User?> registerUser(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("User created: ${userCredential.user?.uid}");
      return userCredential.user;
    } catch (e) {
      print("Registration failed: $e");
      return null;
    }
  }

  // ユーザーログイン
  Future<User?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Login failed: $e");
      return null;
    }
  }

  // ユーザーメタ登録
  Future<void> saveUserDetails(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set(user.toMap());
    } catch (e) {
      print("Error saving user details: $e");
    }
  }

  Future<UserModel?> getUserDetails(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>, uid);
      }
    } catch (e) {
      print("Error fetching user details: $e");
    }
    return null;
  }

  // MFA（電話番号認証）開始
  Future<void> verifyPhoneNumber(String phoneNumber, Function(String) onVerificationComplete) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Phone number verification failed: $e");
      },
      codeSent: (String verificationId, int? resendToken) {
        onVerificationComplete(verificationId); // Verification IDをコールバックで返す
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  // パスワードリセット
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print("Password reset failed: $e");
    }
  }

  // ユーザー情報の取得
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // サインアウト
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
