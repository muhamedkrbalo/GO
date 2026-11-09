import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/model/owner_navigation_tab.dart';
import '../widget/owner_bottom_navigation_bar.dart';

class OwnerNavigationShell extends StatelessWidget {
  const OwnerNavigationShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: OwnerBottomNavigationBar(
        currentTab: OwnerNavigationTab.values[navigationShell.currentIndex],
        onTabSelected: (tab) => navigationShell.goBranch(tab.index),
      ),
    );
  }
}
