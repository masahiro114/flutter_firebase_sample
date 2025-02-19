import 'package:flutter/cupertino.dart';

class UploadView extends StatelessWidget {
  const UploadView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Music')),
      child: Center(
        child: Text(
          'Upload Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}