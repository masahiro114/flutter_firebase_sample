import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class SigninViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// 🔹 Log in user and return `User?` instead of `bool`
  Future<User?> loginUser(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      User? user = await _authService.loginUser(email, password);

      if (user != null) {
        _isLoading = false;
        notifyListeners();
        return user; // ✅ Return the logged-in user
      } else {
        _isLoading = false;
        _errorMessage = "Login failed. Please try again.";
        notifyListeners();
        return null;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = "Error: ${e.toString()}";
      notifyListeners();
      return null;
    }
  }
}
