import 'package:flutter/material.dart';

class Page4xx extends StatelessWidget {
  const Page4xx({
    super.key,
    required this.title,
    this.message,
  });
  final String title;
  final String? message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(message ?? ""),
      ),
    );
  }
}
