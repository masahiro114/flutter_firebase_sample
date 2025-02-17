import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import './../../viewmodels/register_viewmodel.dart';
import './signin_view.dart';
import '../../components/ios_button.dart';
import '../../components/ios_text_field.dart';
import '../../components/ios_text_link.dart';
import '../../components/ios_date_picker.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  DateTime? _selectedDate; // 🔹 Store selected birthday

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterViewModel(),
      child: Consumer<RegisterViewModel>(
        builder: (context, viewModel, child) {
          return CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text('Register'),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iOSTextField(
                    controller: _usernameController,
                    placeholder: 'Username',
                  ),
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 16),

                  /// 🔹 Use the iOS Date Picker
                  IOSDatePicker(
                    onDateSelected: (DateTime date) {
                      setState(() {
                        _selectedDate = date;
                      });
                    },
                  ),

                  const SizedBox(height: 24),

                  viewModel.isLoading
                      ? const CupertinoActivityIndicator()
                      : FullWidthButton(
                    text: 'Register',
                    onPressed: () async {
                      String username = _usernameController.text;
                      String email = _emailController.text;
                      String password = _passwordController.text;

                      if (_selectedDate == null) {
                        print("Please select a birthdate.");
                        return;
                      }

                      bool success = await viewModel.registerUser(
                        username,
                        email,
                        password,
                        _selectedDate!,
                      );

                      if (success) {
                        print("User successfully registered");
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

                  const SizedBox(height: 20),
                  IOSLinkText(
                    text: 'Already have an account? Sign In',
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => SigninView()),
                      );
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
