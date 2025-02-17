import 'package:flutter/cupertino.dart';

class IOSLinkText extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  IOSLinkText({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,  // Remove padding
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: CupertinoColors.activeBlue,  // iOS blue color
          decoration: TextDecoration.underline,  // Underlined style
        ),
      ),
    );
  }
}
