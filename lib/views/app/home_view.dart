import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../models/user_model.dart';
import '../../../services/auth_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final AuthService _authService = AuthService();
  UserModel? _userModel;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  /// 🔹 Fetch user details from Firestore
  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      UserModel? userModel = await _authService.getUserDetails(user.uid);
      if (userModel != null) {
        setState(() {
          _userModel = userModel;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Home'),
      ),
      child: Center(
        child: _userModel == null
            ? const CupertinoActivityIndicator() // Show loading spinner while fetching data
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome, ${_userModel!.username}!",
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            Text(
              "Your Birthday: ${_userModel!.birthDate.year}-${_userModel!.birthDate.month.toString().padLeft(2, '0')}-${_userModel!.birthDate.day.toString().padLeft(2, '0')}",
              style: const TextStyle(fontSize: 18, color: CupertinoColors.systemGrey),
            ),
          ],
        ),
      ),
    );
  }
}
