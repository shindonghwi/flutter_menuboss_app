import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:menuboss_common/ui/colors.dart';
import '../../utils/CollectionUtil.dart';
import '../../utils/Common.dart';
import '../placeholder/ImagePlaceholder.dart';
import '../placeholder/PlaceholderType.dart';

class LoadImage extends StatelessWidget {
  final String? url;
  final ImagePlaceholderType type;
  final String? tag;
  final BoxFit fit;
  final double borderRadius;
  final double borderWidth;
  final Color? backgroundColor;

  const LoadImage({
    super.key,
    required this.url,
    required this.type,
    this.tag,
    this.fit = BoxFit.cover,
    this.borderRadius = 4,
    this.borderWidth = 1,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          width: borderWidth,
          color: getColorScheme(context).colorGray200,
        ),
        color: backgroundColor ?? getColorScheme(context).colorGray100,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
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
