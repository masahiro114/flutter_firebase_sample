import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class SigninViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> loginUser(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    User? user = await _authService.loginUser(email, password);
    if (user != null) {
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _isLoading = false;
      _errorMessage = "SignIn failed. Please try again.";
      notifyListeners();
      return false;
    }
  }
}
