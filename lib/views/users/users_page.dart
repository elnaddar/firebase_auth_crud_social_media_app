import 'package:firebase_auth_crud_social_media_app/components/app_drawer.dart';
import 'package:firebase_auth_crud_social_media_app/repository/users_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(selectedIndex: 2),
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: StreamBuilder(
        stream:
            RepositoryProvider.of<UsersRepository>(context).getUsersSnapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong try again."),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          final users = snapshot.data!.docs;
          return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                final user = users[index].data();
                return Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: user['photoURL'] != null
                          ? Image.network(user['photoURL'])
                          : const Icon(Icons.person),
                    ),
                    title: Text(user['name']),
                    subtitle:
                        Text("@${user['email'].toString().split("@")[0]}"),
                    subtitleTextStyle: TextStyle(color: Colors.grey.shade500),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Divider(
                      indent: 12,
                      endIndent: 12,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
              itemCount: users.length);
        },
      ),
    );
  }
}
