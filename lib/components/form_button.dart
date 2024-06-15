import 'package:firebase_auth_crud_social_media_app/components/smooth_color_filled_button.dart';
import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.text,
    this.onTap,
  });

  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SmoothColorFilledButton(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.all(25),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onTap,
        child: Text(text),
      ),
    );
  }
}
