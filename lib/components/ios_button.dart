import 'package:flutter/cupertino.dart';

class FullWidthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const FullWidthButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CupertinoButton.filled(
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold, // Makes text bold
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
