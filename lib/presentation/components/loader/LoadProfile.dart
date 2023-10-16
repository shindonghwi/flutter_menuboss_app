import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/components/placeholder/ProfilePlaceholder.dart';

class LoadProfile extends StatelessWidget {
  final String url;
  final ProfileImagePlaceholderType type;

  const LoadProfile({
    super.key,
    required this.url,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    double containerSize = 0.0;

    switch (type) {
      case ProfileImagePlaceholderType.Size100x100:
        containerSize = 100;
      case ProfileImagePlaceholderType.Size120x120:
        containerSize = 120;
      default:
        containerSize = 100;
    }

    return SizedBox(
      width: containerSize,
      height: containerSize,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: url,
          placeholder: (context, url) => ProfilePlaceholder(type: type),
          errorWidget: (context, url, error) => ProfilePlaceholder(type: type),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
