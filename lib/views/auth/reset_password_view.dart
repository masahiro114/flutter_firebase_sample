import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import './../../viewmodels/reset_password_viewmodel.dart';
import './signin_view.dart';
import '../../components/ios_button.dart';
import '../../components/ios_text_field.dart';

class ResetPasswordView extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResetPasswordViewModel(),
      child: Consumer<ResetPasswordViewModel>(
        builder: (context, viewModel, child) {
          return CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text('Reset Password'),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iOSTextField(
                    controller: _emailController,
                    placeholder: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  viewModel.isLoading
                      ? const CupertinoActivityIndicator()
                      : FullWidthButton(
                    text: 'Send Reset Link',
                    onPressed: () async {
                      String email = _emailController.text;

                      bool success = await viewModel.sendPasswordReset(email);
                      if (success) {
                        showCupertinoDialog(
                          context: context,
                          builder: (_) => CupertinoAlertDialog(
                            title: const Text('Success'),
                            content: const Text('Password reset email sent! Check your inbox.'),
                            actions: [
                              CupertinoDialogAction(
                                child: const Text('OK'),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        );
                      } else {
                        showCupertinoDialog(
                          context: context,
                          builder: (_) => CupertinoAlertDialog(
                            title: const Text('Error'),
                            content: const Text('Failed to send reset email. Try again.'),
                            actions: [
                              CupertinoDialogAction(
                                child: const Text('OK'),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        );
                      }
                    },
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