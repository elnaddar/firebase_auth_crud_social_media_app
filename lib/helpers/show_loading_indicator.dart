import 'package:flutter/material.dart';

void showLoadingIndicator(BuildContext context) {
  showAdaptiveDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator.adaptive(),
    ),
  );
}
