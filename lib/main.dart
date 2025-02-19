import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './views/auth/register_view.dart';
import './viewmodels/register_viewmodel.dart';
import 'config/navigation_config.dart';
import 'components/ios_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (context) => RegisterViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CupertinoPageScaffold(
              child: Center(child: CupertinoActivityIndicator()),
            );
          } else if (snapshot.hasError) {
            return const CupertinoPageScaffold(
              child: Center(child: Text('Something went wrong')),
            );
          } else if (snapshot.hasData) {
            return iOSNavigation(
              navItems: navItems,
              tabViews: tabViews,
            );
          } else {
            return RegisterView();
          }
        },
      ),
    );
  }
}
