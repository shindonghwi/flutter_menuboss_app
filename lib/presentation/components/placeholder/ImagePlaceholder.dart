import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/dto/Pair.dart';

// small: 60x60, normal: 80x80, large: 120x120
enum PlaceholderType { Small, Normal, Large, AUTO_16x9 }

class ImagePlaceholder extends StatelessWidget {
  final PlaceholderType type;

  const ImagePlaceholder({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    double containerSize = 0.0;
    Pair<double, double> imageSize = Pair(0.0, 0.0);

    switch (type) {
      case PlaceholderType.Small:
        containerSize = 60;
      case PlaceholderType.Normal:
        containerSize = 80;
      case PlaceholderType.Large:
        containerSize = 120;
      default:
        containerSize = 80;
    }

    switch (type) {
      case PlaceholderType.Small:
        imageSize = Pair(36, 18);
      case PlaceholderType.Normal:
        imageSize = Pair(52, 26);
      case PlaceholderType.Large:
        imageSize = Pair(72, 36);
      default:
        imageSize = Pair(52, 26);
    }

    return type == PlaceholderType.AUTO_16x9
        ? SizedBox(
            width: double.infinity,
            child: LayoutBuilder(builder: (context, constraints) {
              return AspectRatio(
                aspectRatio: 16 / 9,
                child: Center(
                  child: SvgPicture.asset(
                    "assets/imgs/icon_logo_text.svg",
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
        : Container(
            width: containerSize,
            height: containerSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: getColorScheme(context).colorGray100,
            ),
            child: Center(
              child: SvgPicture.asset("assets/imgs/icon_logo_text.svg",
                  width: imageSize.first,
                  height: imageSize.second,
                  colorFilter: ColorFilter.mode(
                    getColorScheme(context).colorGray400,
                    BlendMode.srcIn,
                  )),
            ),
          );
  }
}
