import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/data/models/device/RequestDeviceApplyContents.dart';
import 'package:menuboss/data/models/schedule/ResponseSchedulesModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/components/button/PrimaryLineButton.dart';
import 'package:menuboss/presentation/components/loader/LoadImage.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';


class ScheduleItem extends HookWidget {
  final ResponseSchedulesModel item;

  const ScheduleItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final contentTypes = item.property?.contentTypes ?? [];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric( vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: LoadImage(url: item.property?.imageUrl, type: ImagePlaceholderType.Normal),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.name,
                        style: getTextTheme(context).b2m.copyWith(
                          color: getColorScheme(context).colorGray900,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          "${getAppLocalizations(context).common_updated}: ${item.updatedDate}",
                          style: getTextTheme(context).c1m.copyWith(
                            color: getColorScheme(context).colorGray500,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            children: contentTypes.map((e) {
                              return Container(
                                margin: const EdgeInsets.only(right: 4),
                                child: _ContentTypeImage(code: e.code),
                              );
                            }).toList(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              getAppLocalizations(context).count_playlist("${item.property?.count}"),
                              style: getTextTheme(context).c1m.copyWith(
                                color: getColorScheme(context).colorGray500,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          PrimaryLineButton.smallRound100(
            content: getAppLocalizations(context).common_apply,
            isActivated: true,
            onPressed: () {
              Navigator.push(
                context,
                nextSlideHorizontalScreen(
                    RoutingScreen.ApplyDevice.route,
                    parameter: RequestDeviceApplyContents(
                      contentType: "Schedule",
                      contentId: item.scheduleId,
                    )
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class _ContentTypeImage extends StatelessWidget {
  final String code;

  const _ContentTypeImage({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    var typeCode = code.toLowerCase();
    var iconPath = "";

    switch (typeCode) {
      case "image":
        iconPath = "assets/imgs/icon_image.svg";
      case "video":
        iconPath = "assets/imgs/icon_video.svg";
      case "canvas":
        iconPath = "assets/imgs/icon_canvas.svg";
    }

    return SvgPicture.asset(
      iconPath,
      width: 16,
      height: 16,
      colorFilter: ColorFilter.mode(
        getColorScheme(context).colorGray500,
        BlendMode.srcIn,
      ),
    );
  }
}
