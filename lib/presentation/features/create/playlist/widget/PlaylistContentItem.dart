import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/components/bottom_sheet/BottomSheetModifySelector.dart';
import 'package:menuboss/presentation/components/commons/MoreButton.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class PlaylistContentItem extends StatelessWidget {
  final int item;

  const PlaylistContentItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ReorderableDragStartListener(
                index: item,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    "assets/imgs/icon_alignment.svg",
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      getColorScheme(context).colorGray500,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  const ImagePlaceholder(type: ImagePlaceholderType.Small),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/imgs/icon_image.svg",
                              width: 20,
                              height: 20,
                              colorFilter: ColorFilter.mode(
                                getColorScheme(context).colorGray900,
                                BlendMode.srcIn,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "File name ${item}",
                                style: getTextTheme(context).b2sb.copyWith(
                                      color: getColorScheme(context).colorGray900,
                                    ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            "00:00:00",
                            style: getTextTheme(context).c1sb.copyWith(
                                  color: getColorScheme(context).colorGray500,
                                ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onLongPress: () {},
            child: MoreButton(
              items: const [
                ModifyType.Rename,
                ModifyType.Delete,
              ],
              onSelected: (type, text) {},
            ),
          ),
        ],
      ),
    );
  }
}
