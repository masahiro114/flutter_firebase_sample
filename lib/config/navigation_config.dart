import 'package:flutter/cupertino.dart';
import '../views/app/home_view.dart';
import '../views/app/music_view.dart';
import '../views/app/upload_view.dart';
import '../views/app/profile_view.dart';


/// ✅ Global Bottom Navigation Items
final List<BottomNavigationBarItem> navItems = const [
  BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.house),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.music_note),
    label: 'Music',
  ),
  BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.cloud_upload),
    label: 'Upload',
  ),
  BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.person),
    label: 'Profile',
  ),
];

/// ✅ Global Tab Views
final List<Widget> tabViews = const [
  HomeView(),
  MusicView(),
  UploadView(),
  ProfileView(),
];
