import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './../../viewmodels/signin_viewmodel.dart';
import '../../components/ios_button.dart';
import '../../components/ios_text_field.dart';
import './../app/home_view.dart';
import './reset_password_view.dart';

class SigninView extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SigninViewModel(),
      child: Consumer<SigninViewModel>(
        builder: (context, viewModel, child) {
          return CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text('Signin'),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iOSTextField(
                    controller: _emailController,
                    placeholder: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  iOSTextField(
                    controller: _passwordController,
                    placeholder: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 24),
                  CupertinoButton(
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: CupertinoColors.activeBlue),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => ResetPasswordView(),
                          ),
                        );
                      },
                  ),
                  const SizedBox(height: 24),
                  viewModel.isLoading
                      ? const CupertinoActivityIndicator()
                      : FullWidthButton(
                    text: 'Signin',
                    onPressed: () async {
                      String email = _emailController.text;
                      String password = _passwordController.text;

                      /// 🔹 Authenticate user
                      User? user = await viewModel.loginUser(email, password);

                      if (user != null) {
                        print("User successfully logged in");

                        /// 🔹 Navigate to HomeView (No need to pass username)
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const HomeView(),
                          ),
                        );
                      } else {
                        print("Error: ${viewModel.errorMessage}");
                      }
                    },
                  ),
                  if (viewModel.errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        viewModel.errorMessage!,
                        style: const TextStyle(color: CupertinoColors.systemRed),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
