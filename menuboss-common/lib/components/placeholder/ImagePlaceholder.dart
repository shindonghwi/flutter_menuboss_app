import 'package:flutter/material.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';

import '../../ui/colors.dart';
import '../../utils/Common.dart';
import '../../utils/dto/Pair.dart';
import 'PlaceholderType.dart';

class ImagePlaceholder extends StatelessWidget {
  final ImagePlaceholderType type;

  const ImagePlaceholder({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    double containerSize = 0.0;
    Pair<double, double> imageSize = Pair(0.0, 0.0);

    switch (type) {
      case ImagePlaceholderType.Size_32:
        containerSize = 32;
        imageSize = Pair(19, 9.5);
        break;
      case ImagePlaceholderType.Size_48:
        containerSize = 48;
        imageSize = Pair(28, 14);
        break;
      case ImagePlaceholderType.Size_60:
        containerSize = 60;
        imageSize = Pair(36, 18);
        break;
      case ImagePlaceholderType.Size_80:
        containerSize = 80;
        imageSize = Pair(52, 26);
        break;
      case ImagePlaceholderType.Size_120:
        containerSize = 120;
        imageSize = Pair(61, 30);
        break;
      case ImagePlaceholderType.Size_140:
        containerSize = 140;
        imageSize = Pair(72, 36);
        break;
      default:
        containerSize = 80;
        imageSize = Pair(52, 26);
    }

    return type == ImagePlaceholderType.AUTO_16x9
        ? SizedBox(
            width: double.infinity,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Center(
                    child: LoadSvg(
                      path: "assets/imgs/image_logo_text.svg",
                      width: constraints.maxWidth * 0.28,
                      height: constraints.maxHeight * 0.24,
                      color: getColorScheme(context).colorGray400,
                    ),
                  ),
                );
              },
            ),
          )
        : SizedBox(
            width: containerSize,
            height: containerSize,
            child: Center(
              child: LoadSvg(
                path: "assets/imgs/image_logo_text.svg",
                width: imageSize.first,
                height: imageSize.second,
                color: getColorScheme(context).colorGray400,
              ),
            ),
          );
  }
}
