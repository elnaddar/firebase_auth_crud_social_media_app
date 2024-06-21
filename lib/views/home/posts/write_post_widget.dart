import 'package:flutter/material.dart';

class WritePostWidget extends StatelessWidget {
  const WritePostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TextField(
            minLines: 3,
            maxLines: 5,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              fillColor: Colors.transparent,
              hintText: "What do you think...",
            ),
          ),
          SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  side: BorderSide.none,
                  shape: const RoundedRectangleBorder(),
                  foregroundColor: Colors.deepPurple,
                ),
                child: const Text("Post"),
              ))
        ],
      ),
    );
  }
}
