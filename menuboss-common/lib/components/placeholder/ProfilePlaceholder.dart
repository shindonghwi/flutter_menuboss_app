import 'package:flutter/material.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';

import '../../ui/colors.dart';
import '../../utils/Common.dart';
import '../../utils/dto/Pair.dart';
import 'PlaceholderType.dart';

class ProfilePlaceholder extends StatelessWidget {
  final ProfileImagePlaceholderType type;

  const ProfilePlaceholder({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    double containerSize = 0.0;
    Pair<double, double> imageSize = Pair(0.0, 0.0);

    switch (type) {
      case ProfileImagePlaceholderType.Size80x80:
        containerSize = 80;
        imageSize = Pair(32, 16);
        break;
      case ProfileImagePlaceholderType.Size100x100:
        containerSize = 100;
        imageSize = Pair(40, 20);
        break;
      case ProfileImagePlaceholderType.Size120x120:
        containerSize = 120;
        imageSize = Pair(60, 30);
        break;
      default:
        containerSize = 100;
        imageSize = Pair(40, 20);
    }

    return SizedBox(
      width: containerSize,
      height: containerSize,
      child: Center(
        child: LoadSvg(
          path: "assets/imgs/image_logo_text.svg",
          width: imageSize.first,
          height: imageSize.second,
          color: getColorScheme(context).colorGray200,
        ),
      ),
    );
  }
}
