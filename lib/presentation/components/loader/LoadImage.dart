import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class LoadImage extends StatelessWidget {
  final String? url;
  final ImagePlaceholderType type;
  final String? tag;
  final BoxFit fit;

  const LoadImage({
    super.key,
    required this.url,
    required this.type,
    this.tag,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          width: 1,
          color: getColorScheme(context).colorGray200,
        ),
        color: getColorScheme(context).colorGray100,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: !CollectionUtil.isNullEmptyFromString(url)
            ? CollectionUtil.isNullEmptyFromString(tag)
                ? CachedNetworkImage(
                    imageUrl: url.toString(),
                    placeholder: (context, url) => ImagePlaceholder(type: type),
                    errorWidget: (context, url, error) => ImagePlaceholder(type: type),
                    fit: fit,
                  )
                : Hero(
                    tag: tag.toString(),
                    child: CachedNetworkImage(
                      imageUrl: url.toString(),
                      placeholder: (context, url) => ImagePlaceholder(type: type),
                      errorWidget: (context, url, error) => ImagePlaceholder(type: type),
                      fit: fit,
                    ),
                  )
            : ImagePlaceholder(type: type),
      ),
    );
  }
}
