import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/dto/Pair.dart';

enum ProfileImagePlaceholderType { Size80x80, Size100x100, Size120x120 }

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
      case ProfileImagePlaceholderType.Size100x100:
        containerSize = 100;
        imageSize = Pair(40, 20);
      case ProfileImagePlaceholderType.Size120x120:
        containerSize = 120;
        imageSize = Pair(60, 30);
      default:
        containerSize = 100;
        imageSize = Pair(40, 20);
    }

    return SizedBox(
      width: containerSize,
      height: containerSize,
      child: Center(
        child: SvgPicture.asset(
          "assets/imgs/image_logo_text.svg",
          width: imageSize.first,
          height: imageSize.second,
          colorFilter: ColorFilter.mode(
            getColorScheme(context).colorGray200,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
