import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import './../../models/user_model.dart';

class RegisterViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> registerUser(
      String username, String email, String password, DateTime birthDate) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Register user in Firebase Authentication
      User? user = await _authService.registerUser(email, password);

      if (user != null) {
        // 🔹 Save user details (username, birthDate) in Firestore
        UserModel userModel = UserModel(
          uid: user.uid,
          username: username,
          email: email,
          birthDate: birthDate,
          createdAt: DateTime.now(),
        );

        // 🔹 Save user details in Firestore
        await _authService.saveUserDetails(userModel);

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        _errorMessage = "Registration failed. Please try again.";
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = "Error: ${e.toString()}";
      notifyListeners();
      return false;
    }
  }
}
