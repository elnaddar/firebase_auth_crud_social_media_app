import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    this.selectedIndex = 0,
  });
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) => _onDestinationSelected(context, index),
      children: const [
        DrawerHeader(
          margin: EdgeInsets.fromLTRB(26, 0, 26, 8),
          child: Icon(Icons.favorite),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: Text("Home"),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.person_outlined),
          selectedIcon: Icon(Icons.person),
          label: Text("Profile"),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.group_outlined),
          selectedIcon: Icon(Icons.group),
          label: Text("Users"),
        ),
        Divider(
          indent: 26,
          endIndent: 26,
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.logout_outlined),
          selectedIcon: Icon(Icons.logout),
          label: Text("Logout"),
        ),
      ],
    );
  }

  void _onDestinationSelected(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go("/");
      case 1:
        context.push("/profile");
      case 2:
        context.push("/users");
      case 4:
        context.go("/logout");
    }
  }
}
