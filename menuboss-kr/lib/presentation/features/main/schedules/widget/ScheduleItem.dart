import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/data/models/device/RequestDeviceApplyContents.dart';
import 'package:menuboss/data/models/schedule/ResponseSchedulesModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss_common/components/button/PrimaryLineButton.dart';
import 'package:menuboss_common/components/loader/LoadImage.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/components/placeholder/PlaceholderType.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/Strings.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 16),
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
                          "${Strings.of(context).commonUpdated}: ${item.updatedDate}",
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
                              Strings.of(context).count_playlist(item.property?.count ?? 0),
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
            content: Strings.of(context).commonConnectScreen,
            isActivated: true,
            onPressed: () {
              Navigator.push(
                context,
                nextSlideHorizontalScreen(RoutingScreen.ApplyDevice.route,
                    parameter: RequestDeviceApplyContents(
                      contentType: "Schedule",
                      contentId: item.scheduleId,
                    )),
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
        break;
      case "video":
        iconPath = "assets/imgs/icon_video.svg";
        break;
      case "canvas":
        iconPath = "assets/imgs/icon_canvas.svg";
        break;
    }

    return LoadSvg(
      path: iconPath,
      width: 16,
      height: 16,
      color: getColorScheme(context).colorGray500,
    );
  }
}
