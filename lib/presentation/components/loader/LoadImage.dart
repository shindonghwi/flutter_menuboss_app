import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';

class LoadImage extends StatelessWidget {
  final String? url;
  final ImagePlaceholderType type;
  final String? tag;

  const LoadImage({
    super.key,
    required this.url,
    required this.type,
    this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: !CollectionUtil.isNullEmptyFromString(url)
          ? CollectionUtil.isNullEmptyFromString(tag)
              ? CachedNetworkImage(
                  imageUrl: url.toString(),
                  placeholder: (context, url) => ImagePlaceholder(type: type),
                  errorWidget: (context, url, error) => ImagePlaceholder(type: type),
                  fit: BoxFit.cover,
                )
              : Hero(
                  tag: tag.toString(),
                  child: CachedNetworkImage(
                    imageUrl: url.toString(),
                    placeholder: (context, url) => ImagePlaceholder(type: type),
                    errorWidget: (context, url, error) => ImagePlaceholder(type: type),
                    fit: BoxFit.cover,
                  ),
                )
          : ImagePlaceholder(type: type),
    );
  }
}
