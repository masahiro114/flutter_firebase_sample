import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class iOSNavigation extends StatelessWidget {
  final List<BottomNavigationBarItem> navItems;
  final List<Widget> tabViews;

  const iOSNavigation({
    Key? key,
    required this.navItems,
    required this.tabViews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: navItems,
        backgroundColor: CupertinoColors.systemGrey6.withOpacity(0.9),
        iconSize: 28,
        height: 40 + bottomPadding,
      ),
      tabBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: bottomPadding > 0 ? bottomPadding : 0),
          child: CupertinoTabView(
            builder: (context) => tabViews[index],
          ),
        );
      },
    );
  }
}
