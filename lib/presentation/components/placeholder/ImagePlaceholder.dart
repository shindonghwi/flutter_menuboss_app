import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/dto/Pair.dart';

// small: 60x60, normal: 80x80, large: 140x140
enum ImagePlaceholderType { Small, Normal, Large, AUTO_16x9 }

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
      case ImagePlaceholderType.Small:
        containerSize = 60;
        imageSize = Pair(36, 18);
      case ImagePlaceholderType.Normal:
        containerSize = 80;
        imageSize = Pair(52, 26);
      case ImagePlaceholderType.Large:
        containerSize = 140;
        imageSize = Pair(72, 36);
      default:
        containerSize = 80;
        imageSize = Pair(52, 26);
    }

    return type == ImagePlaceholderType.AUTO_16x9
        ? SizedBox(
            width: double.infinity,
            child: LayoutBuilder(builder: (context, constraints) {
              return AspectRatio(
                aspectRatio: 16 / 9,
                child: Center(
                  child: SvgPicture.asset(
                    "assets/imgs/image_logo_text.svg",
                    width: constraints.maxWidth * 0.28,
                    height: constraints.maxHeight * 0.24,
                    colorFilter: ColorFilter.mode(
                      getColorScheme(context).colorGray400,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              );
            }),
          )
        : SizedBox(
            width: containerSize,
            height: containerSize,
            child: Center(
              child: SvgPicture.asset(
                "assets/imgs/image_logo_text.svg",
                width: imageSize.first,
                height: imageSize.second,
                colorFilter: ColorFilter.mode(
                  getColorScheme(context).colorGray400,
                  BlendMode.srcIn,
                ),
              ),
            ),
          );
  }
}
