import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistModel.dart';
import 'package:menuboss/data/models/schedule/SimpleSchedulesModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/bottom_sheet/BottomSheetTimeSetting.dart';
import 'package:menuboss/presentation/components/bottom_sheet/CommonBottomSheet.dart';
import 'package:menuboss/presentation/components/button/ErrorLineButton.dart';
import 'package:menuboss/presentation/components/button/NeutralLineButton.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/components/divider/DividerVertical.dart';
import 'package:menuboss/presentation/components/loader/LoadImage.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/features/create/schedule/provider/ScheduleSaveInfoProvider.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import '../provider/ScheduleTimelineInfoProvider.dart';

class ScheduleContentItem extends HookConsumerWidget {
  const ScheduleContentItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timelineState = ref.watch(ScheduleTimelineInfoProvider);
    final timelineProvider = ref.read(ScheduleTimelineInfoProvider.notifier);
    final saveProvider = ref.read(ScheduleSaveInfoProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        saveProvider.changeContentPlaylist(timelineState);
      });
      return null;
    }, [timelineState]);

    void goToSelectPlaylist(SimpleSchedulesModel data) async {
      try {
        final playlistInfo = await Navigator.push(
          context,
          nextSlideHorizontalScreen(
            RoutingScreen.SelectPlaylist.route,
            parameter: timelineState.map((e) => e.playlistId!).toList(),
          ),
        );

        if (playlistInfo is ResponsePlaylistModel) {
          final updatedItem = data.copyWith(
            playlistId: playlistInfo.playlistId,
            playListName: playlistInfo.name,
            imageUrl: playlistInfo.property?.imageUrl ?? "",
          );
          timelineProvider.updateItem(data.playlistId, updatedItem);
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    void showTimeSettingBottomSheet(SimpleSchedulesModel data) async {
      CommonBottomSheet.showBottomSheet(
        context,
        child: BottomSheetTimeSetting(
          startTime: data.start.toString(),
          endTime: data.end.toString(),
          callback: (startTime, endTime) {
            timelineProvider.updateItem(
              data.playlistId,
              data.copyWith(
                start: startTime,
                end: endTime,
              ),
            );
          },
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              getAppLocalizations(context).common_title,
              style: getTextTheme(context).b3sb.copyWith(
                    color: getColorScheme(context).colorGray500,
                  ),
            ),
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) {
              return const DividerVertical(
                marginVertical: 0,
                height: 1,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              final data = timelineState[index];
              return data.isAddButton
                  ? Container(
                      width: 150,
                      margin: const EdgeInsets.all(70),
                      child: PrimaryFilledButton.mediumRound100Icon(
                        leftIcon: SvgPicture.asset(
                          "assets/imgs/icon_plus.svg",
                          width: 20.0,
                          height: 20.0,
                          colorFilter: ColorFilter.mode(
                            getColorScheme(context).white,
                            BlendMode.srcIn,
                          ),
                        ),
                        content: getAppLocalizations(context).create_schedule_new_timeline,
                        isActivated: true,
                        onPressed: () => timelineProvider.addItem(),
                      ),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 140,
                                  height: 140,
                                  child: LoadImage(
                                    url: data.imageUrl,
                                    type: ImagePlaceholderType.Large,
                                  ),
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 140,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.5),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              if (data.isRequired)
                                                Text(
                                                  "*",
                                                  style: getTextTheme(context).s2b.copyWith(
                                                        color: getColorScheme(context).colorSecondary500,
                                                      ),
                                                ),
                                              Text(
                                                data.playListName,
                                                style: getTextTheme(context).s2b.copyWith(
                                                      color: getColorScheme(context).colorGray900,
                                                    ),
                                              )
                                            ],
                                          ),
                                          ConstrainedBox(
                                            constraints: const BoxConstraints(
                                              minWidth: 180,
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: data.timeIsDuplicate
                                                      ? ErrorLineButton.extraSmallRound4Icon(
                                                          leftIcon: SvgPicture.asset(
                                                            "assets/imgs/icon_time.svg",
                                                            width: 20,
                                                            height: 20,
                                                            colorFilter: ColorFilter.mode(
                                                              getColorScheme(context).colorGray900,
                                                              BlendMode.srcIn,
                                                            ),
                                                          ),
                                                          content: "${data.start} ~ ${data.end}",
                                                          isActivated: true,
                                                          onPressed: () => showTimeSettingBottomSheet(data),
                                                        )
                                                      : NeutralLineButton.extraSmallRound4Icon(
                                                          leftIcon: SvgPicture.asset("assets/imgs/icon_time.svg"),
                                                          content: "${data.start} ~ ${data.end}",
                                                          isActivated: true,
                                                          onPressed: () => showTimeSettingBottomSheet(data),
                                                        ),
                                                ),
                                                const SizedBox(
                                                  height: 4.0,
                                                ),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: NeutralLineButton.extraSmallRound4Icon(
                                                    leftIcon: SvgPicture.asset(
                                                      data.playlistId == null || data.playlistId! < 0
                                                          ? "assets/imgs/icon_plus.svg"
                                                          : "assets/imgs/icon_edit.svg",
                                                      width: 20,
                                                      height: 20,
                                                      colorFilter: ColorFilter.mode(
                                                        getColorScheme(context).colorGray900,
                                                        BlendMode.srcIn,
                                                      ),
                                                    ),
                                                    content: data.playlistId == null || data.playlistId! < 0
                                                        ? getAppLocalizations(context).create_schedule_add_playlist
                                                        : getAppLocalizations(context).create_schedule_change_playlist,
                                                    isActivated: true,
                                                    onPressed: () => goToSelectPlaylist(data),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          if (!data.isRequired)
                            Align(
                                alignment: Alignment.topRight,
                                child: Clickable(
                                  onPressed: () => timelineProvider.removeItem(data.playlistId!),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SvgPicture.asset(
                                      "assets/imgs/icon_trash.svg",
                                      width: 24.0,
                                      height: 24.0,
                                      colorFilter: ColorFilter.mode(
                                        getColorScheme(context).colorGray500,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ))
                        ],
                      ),
                    );
            },
            itemCount: timelineState.length,
          ),
        ],
      ),
    );
  }
}
