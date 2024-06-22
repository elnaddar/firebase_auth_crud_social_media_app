import 'dart:io';

import 'package:firebase_auth_crud_social_media_app/cubits/user_cubit/user_cubit.dart';
import 'package:firebase_auth_crud_social_media_app/helpers/show_loading_indicator.dart';
import 'package:firebase_auth_crud_social_media_app/repository/users_repository.dart';
import 'package:firebase_auth_crud_social_media_app/services/image_uploader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ImageUploaderButton extends StatefulWidget {
  const ImageUploaderButton({super.key});

  @override
  State<ImageUploaderButton> createState() => _ImageUploaderButtonState();
}

class _ImageUploaderButtonState extends State<ImageUploaderButton> {
  _upload() async {
    final uploader = ImageUploader();
    if (Platform.isAndroid || Platform.isIOS) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return const Placeholder();
              },
            );
          });
    } else {
      await uploader.pickImageFromGallery();
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
  }

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: _upload,
      style:
          IconButton.styleFrom(side: const BorderSide(color: Colors.black54)),
      icon: const Icon(Icons.camera_alt),
    );
  }
}
