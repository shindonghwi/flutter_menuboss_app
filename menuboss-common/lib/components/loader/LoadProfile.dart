import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:menuboss_common/components/loader/LoadExtension.dart';
import 'package:menuboss_common/ui/colors.dart';

import '../../utils/CollectionUtil.dart';
import '../../utils/Common.dart';
import '../placeholder/PlaceholderType.dart';
import '../placeholder/ProfilePlaceholder.dart';

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
      case ProfileImagePlaceholderType.Size80x80:
        containerSize = 80;
        break;
      case ProfileImagePlaceholderType.Size100x100:
        containerSize = 100;
        break;
      case ProfileImagePlaceholderType.Size120x120:
        containerSize = 120;
        break;
      default:
        containerSize = 100;
    }

    return SizedBox(
      width: containerSize,
      height: containerSize,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: getColorScheme(context).colorGray100,
          border: Border.all(
            color: getColorScheme(context).colorGray200,
            width: 1,
          ),
        ),
        child: ClipOval(
          child: !CollectionUtil.isNullEmptyFromString(url)
              ? CachedNetworkImage(
                  imageUrl: url,
                  memCacheWidth: containerSize.cacheSize(context),
                  memCacheHeight: containerSize.cacheSize(context),
                  placeholder: (context, url) => ProfilePlaceholder(type: type),
                  errorWidget: (context, url, error) => ProfilePlaceholder(type: type),
                  fit: BoxFit.cover,
                )
              : ProfilePlaceholder(type: type),
        ),
      ),
    );
  }
}
