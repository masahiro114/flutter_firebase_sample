import 'package:flutter/cupertino.dart';

class iOSTextField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final bool obscureText;
  final EdgeInsets padding;
  final TextInputType keyboardType; // Correct type

  const iOSTextField({
    Key? key,
    required this.controller,
    required this.placeholder,
    this.keyboardType = TextInputType.text, // Default to normal text input
    this.obscureText = false, // Default to false
    this.padding = const EdgeInsets.all(16.0), // Default padding
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      placeholder: placeholder,
      obscureText: obscureText,
      padding: padding,
      keyboardType: keyboardType, // Now properly used
    );
  }
}
