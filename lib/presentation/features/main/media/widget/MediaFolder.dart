import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import '../model/MediaItem.dart';

class MediaFolder extends StatelessWidget {
  final MediaItem item;

  const MediaFolder({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 92,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/imgs/icon_folder.svg",
                width: 60,
                height: 60,
              ),
              const SizedBox(width: 16),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.fileName,
                    style: getTextTheme(context).b1sb.copyWith(
                          color: getColorScheme(context).colorGray900,
                        ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "${item.folderCount} File (${item.size})",
                    style: getTextTheme(context).b1sb.copyWith(
                          color: getColorScheme(context).colorGray500,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
