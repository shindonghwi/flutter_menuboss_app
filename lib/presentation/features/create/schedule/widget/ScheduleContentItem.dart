import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistsModel.dart';
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

import '../../../select/playlist/SelectPlaylistScreen.dart';
import '../provider/ScheduleTimelineInfoProvider.dart';

class ScheduleContentItem extends HookConsumerWidget {
  final List<ResponsePlaylistsModel>? playlists;

  const ScheduleContentItem({
    super.key,
    required this.playlists,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timelineState = ref.watch(scheduleTimelineInfoProvider);
    final timelineProvider = ref.read(scheduleTimelineInfoProvider.notifier);
    final saveProvider = ref.read(ScheduleSaveInfoProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        saveProvider.changeContentPlaylist(timelineState);
      });
      return null;
    }, [timelineState]);

    void goToSelectPlaylist(int index, SimpleSchedulesModel data) async {
      try {
        SelectedPlaylistInfo? selectedPlaylistInfo = SelectedPlaylistInfo(
          playlistIds: timelineState.map((e) => e.playlistId!).toList(),
          playlistId: data.playlistId ?? -1,
          playlistName: data.playListName,
          start: data.start,
          end: data.end,
        );

        final playlistInfo = await Navigator.push(
          context,
          nextSlideHorizontalScreen(
            RoutingScreen.SelectPlaylist.route,
            parameter: selectedPlaylistInfo,
          ),
        );

        if (playlistInfo is ResponsePlaylistsModel) {
          final updatedItem = data.copyWith(
            playlistId: playlistInfo.playlistId,
            playListName: playlistInfo.name,
            imageUrl: playlistInfo.property?.imageUrl ?? "",
          );
          timelineProvider.updateItemByIndex(index, updatedItem);
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
            timelineProvider.updateItemById(
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Text(
            getAppLocalizations(context).common_timeline,
            style: getTextTheme(context).b3sb.copyWith(
                  color: getColorScheme(context).colorGray900,
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
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 70, horizontal: 105),
                    child: PrimaryFilledButton.mediumRound100Icon(
                      leftIcon: SvgPicture.asset(
                        "assets/imgs/icon_plus_1.svg",
                        width: 20.0,
                        height: 20.0,
                        colorFilter: ColorFilter.mode(
                          getColorScheme(context).white,
                          BlendMode.srcIn,
                        ),
                      ),
                      content: getAppLocalizations(context).create_schedule_new_playlist_plus,
                      isActivated: true,
                      onPressed: () => timelineProvider.addItem(
                        defaultTitle: getAppLocalizations(context).create_schedule_new_playlist,
                      ),
                    ),
                  )
                : SizedBox(
                    width: double.infinity,
                    height: 188,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 24.0),
                          child: SizedBox(
                            width: 140,
                            height: 140,
                            child: LoadImage(
                              url: data.imageUrl,
                              type: ImagePlaceholderType.Large,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(top: 12, right: 12, bottom: 24),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: data.isRequired ? 12 : 0),
                                        child: Row(
                                          children: [
                                            if (data.isRequired)
                                              Text(
                                                "* ",
                                                style: getTextTheme(context).s3sb.copyWith(
                                                      color: getColorScheme(context).colorSecondary500,
                                                    ),
                                              ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.only(right: data.isRequired ? 16.0 : 0),
                                                child: Text(
                                                  data.playListName,
                                                  style: getTextTheme(context).s3sb.copyWith(
                                                        color: getColorScheme(context).colorGray900,
                                                      ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (!data.isRequired)
                                      Clickable(
                                        onPressed: () => timelineProvider.removeItemByIndex(index),
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
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
                                      )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      data.start == null && data.end == null || index == 0
                                          ? Padding(
                                              padding: const EdgeInsets.only(bottom: 14.5),
                                              child: Text(
                                                "${getAppLocalizations(context).common_time} 00:00 ~ 24:00",
                                                style: getTextTheme(context).b3sb.copyWith(
                                                      color: getColorScheme(context).colorGray900,
                                                    ),
                                              ),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.only(bottom: 4.0),
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: data.timeIsDuplicate
                                                    ? ErrorLineButton.extraSmallRound4Icon(
                                                        leftIcon: SvgPicture.asset(
                                                          "assets/imgs/icon_time_edit.svg",
                                                          width: 20,
                                                          height: 20,
                                                          colorFilter: ColorFilter.mode(
                                                            getColorScheme(context).colorRed500,
                                                            BlendMode.srcIn,
                                                          ),
                                                        ),
                                                        content: "${data.start} ~ ${data.end}",
                                                        isActivated: true,
                                                        onPressed: () => showTimeSettingBottomSheet(data),
                                                      )
                                                    : NeutralLineButton.smallRound4Icon(
                                                        leftIcon: SvgPicture.asset(
                                                          "assets/imgs/icon_time_edit.svg",
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
                                                      ),
                                              ),
                                            ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4.0),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: NeutralLineButton.smallRound4Icon(
                                            leftIcon: SvgPicture.asset(
                                              data.playlistId == null || data.playlistId! < 0
                                                  ? "assets/imgs/icon_plus_1.svg"
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
                                            onPressed: () => goToSelectPlaylist(index, data),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
          },
          itemCount: timelineState.length,
        ),
      ],
    );
  }
}
