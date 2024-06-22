import 'package:firebase_auth_crud_social_media_app/components/app_cache_net_image.dart';
import 'package:firebase_auth_crud_social_media_app/repository/users_repository.dart';
import 'package:firebase_auth_crud_social_media_app/views/profile/image_uploader_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userRepo = RepositoryProvider.of<UsersRepository>(context);
    var userData = userRepo.getCurrentUserData();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder(
          stream: userRepo.userRef.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              userData = snapshot.data!.data();
            }
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: userData['photoURL'] != null
                            ? const EdgeInsets.all(0)
                            : const EdgeInsets.all(25),
                        child: userData['photoURL'] != null
                            ? AppCacheNetImage(imageUrl: userData['photoURL'])
                            : const Icon(Icons.person, size: 64),
                      ),
                      const Positioned(
                        bottom: -15,
                        right: -15,
                        child: ImageUploaderButton(),
                      )
                    ],
                  ),
                  const SizedBox(height: 25),
                  Text(
                    userData['name']!,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    userData['email']!,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
