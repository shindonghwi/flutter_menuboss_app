import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';

class LoadImage extends StatelessWidget {
  final String? url;
  final ImagePlaceholderType type;

  const LoadImage({
    super.key,
    required this.url,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url.toString(),
      placeholder: (context, url) => ImagePlaceholder(type: type),
      errorWidget: (context, url, error) => ImagePlaceholder(type: type),
      fit: BoxFit.cover,
    );
  }
}
