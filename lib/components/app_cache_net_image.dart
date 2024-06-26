import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCacheNetImage extends StatelessWidget {
  const AppCacheNetImage({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
