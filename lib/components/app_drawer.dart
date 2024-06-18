import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const NavigationDrawer(
      children: [
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
}
