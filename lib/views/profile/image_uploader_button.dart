import 'dart:io';
import 'package:firebase_auth_crud_social_media_app/cubits/user_cubit/user_cubit.dart';
import 'package:firebase_auth_crud_social_media_app/helpers/show_loading_indicator.dart';
import 'package:firebase_auth_crud_social_media_app/repository/users_repository.dart';
import 'package:firebase_auth_crud_social_media_app/services/image_uploader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

enum Picker { camera, gallery }

class ImageUploaderButton extends StatefulWidget {
  const ImageUploaderButton({super.key});

  @override
  State<ImageUploaderButton> createState() => _ImageUploaderButtonState();
}

class _ImageUploaderButtonState extends State<ImageUploaderButton> {
  final uploader = ImageUploader();

  _upload(Picker picker) async {
    if (picker == Picker.camera) {
      await uploader.pickImageUsingCamera();
    } else {
      await uploader.pickImageFromGallery();
    }

    if (mounted) {
      showLoadingIndicator(context);
    }
    final photoURL = await uploader.uploadFile().onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
      }
      return null;
    });
    if (mounted && photoURL != null) {
      await context.read<UsersRepository>().updateUserImage(photoURL);
    }
    if (mounted && photoURL != null) {
      final userCubit = UserCubit();
      final user = context.read<UsersRepository>();
      final userRef = await user.userRef.get();
      final userData = userRef.data() as Map<String, dynamic>;
      userCubit.cacheUserData(user.currentUser!.uid, userData);
    }
    if (mounted) {
      context.pop();
    }
  }

  _pick() async {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      showModalBottomSheet(
          context: context,
          shape: const ContinuousRectangleBorder(),
          builder: (context) {
            return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return Wrap(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.image),
                      title: const Text("Upload from Gallery"),
                      onTap: () {
                        context.pop();
                        _upload(Picker.gallery);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.camera_alt),
                      title: const Text("Capture an Image"),
                      onTap: () {
                        context.pop();
                        _upload(Picker.camera);
                      },
                    ),
                  ],
                );
              },
            );
          });
    } else {
      _upload(Picker.gallery);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: _pick,
      style:
          IconButton.styleFrom(side: const BorderSide(color: Colors.black54)),
      icon: const Icon(Icons.camera_alt),
    );
  }
}
