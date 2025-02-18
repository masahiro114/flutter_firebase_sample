import 'package:flutter/cupertino.dart';
import '../services/auth_service.dart';

class ResetPasswordViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// 🔹 Send password reset email
  Future<bool> sendPasswordReset(String email) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    bool success = await _authService.sendPasswordResetEmail(email);
    _isLoading = false;
    notifyListeners();
    return success;
  }
}