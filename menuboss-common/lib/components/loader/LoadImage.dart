import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:menuboss_common/components/loader/LoadExtension.dart';
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
    int memCacheHeight;
    int memCacheWidth;

    switch (type) {
      case ImagePlaceholderType.Size_32:
        memCacheWidth = 32.cacheSize(context);
        memCacheHeight = 32.cacheSize(context);
        break;
      case ImagePlaceholderType.Size_48:
        memCacheWidth = 48.cacheSize(context);
        memCacheHeight = 48.cacheSize(context);
        break;
      case ImagePlaceholderType.Size_60:
        memCacheWidth = 60.cacheSize(context);
        memCacheHeight = 60.cacheSize(context);
        break;
      case ImagePlaceholderType.Size_80:
        memCacheWidth = 80.cacheSize(context);
        memCacheHeight = 80.cacheSize(context);
        break;
      case ImagePlaceholderType.Size_120:
        memCacheWidth = 120.cacheSize(context);
        memCacheHeight = 120.cacheSize(context);
        break;
      case ImagePlaceholderType.Size_140:
        memCacheWidth = 140.cacheSize(context);
        memCacheHeight = 140.cacheSize(context);
        break;
      case ImagePlaceholderType.AUTO_16x9:
        memCacheWidth = 160.cacheSize(context);
        memCacheHeight = 90.cacheSize(context);
        break;
      default:
        memCacheWidth = 80.cacheSize(context);
        memCacheHeight = 80.cacheSize(context);
    }

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
                    memCacheWidth: memCacheWidth,
                    memCacheHeight: memCacheHeight,
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
