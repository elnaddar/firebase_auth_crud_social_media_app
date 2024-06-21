import 'package:firebase_auth_crud_social_media_app/repository/posts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_map/form_map.dart';

enum PostEnum { title, content, imageURL }

class WritePostWidget extends StatefulWidget {
  const WritePostWidget({super.key});

  @override
  State<WritePostWidget> createState() => _WritePostWidgetState();
}

class _WritePostWidgetState extends State<WritePostWidget> {
  final formMap = FormMap<PostEnum>(key: GlobalKey<FormState>());

  _submit() {
    formMap.submit((data) {
      context
          .read<PostsRepository>()
          .createPost(content: formMap[PostEnum.content]);
    });
    formMap.key.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
      ),
      child: Form(
        key: formMap.key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                fillColor: Colors.transparent,
                hintText: "What do you think...",
              ),
              onSaved: (newValue) => formMap[PostEnum.content] = newValue,
              validator: (value) {
                if (value == null || value.trim().length < 3) {
                  return "Post content can't be less than 3 characters.";
                }
                return null;
              },
            ),
            SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: _submit,
                  style: TextButton.styleFrom(
                    side: BorderSide.none,
                    shape: const RoundedRectangleBorder(),
                    foregroundColor: Colors.deepPurple,
                  ),
                  child: const Text("Post"),
                ))
          ],
        ),
      ),
    );
  }
}
