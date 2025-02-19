import 'package:flutter/cupertino.dart';
import '../../../services/auth_service.dart';
import '../auth/register_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  void _logout(BuildContext context) async {
    await AuthService().signOut();

    // Navigate back to the Register/Login screen after logout
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(builder: (context) => RegisterView()),
    );
  }

  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Profile')),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Profile Page',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            CupertinoButton.filled(
              child: const Text('Logout'),
              onPressed: () => _logout(context),
            ),
          ],
        ),
      ),
    );
  }
}