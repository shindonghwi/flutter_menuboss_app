import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/schedule/ResponseScheduleModel.dart';
import 'package:menuboss/data/models/schedule/ResponseSchedulesModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/features/detail/schedule/provider/DelScheduleProvider.dart';
import 'package:menuboss/presentation/features/detail/schedule/provider/GetScheduleProvider.dart';
import 'package:menuboss_common/components/appbar/TopBarIconTitleIcon.dart';
import 'package:menuboss_common/components/divider/DividerVertical.dart';
import 'package:menuboss_common/components/loader/LoadImage.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/components/placeholder/PlaceholderType.dart';
import 'package:menuboss_common/components/popup/CommonPopup.dart';
import 'package:menuboss_common/components/popup/PopupDelete.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/components/view_state/EmptyView.dart';
import 'package:menuboss_common/components/view_state/FailView.dart';
import 'package:menuboss_common/components/view_state/LoadingView.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/Strings.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/CollectionUtil.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/UiState.dart';
import 'package:menuboss_common/utils/dto/Pair.dart';

import '../../../../data/models/playlist/ResponsePlaylistsModel.dart';
import '../../main/schedules/provider/SchedulesProvider.dart';

class DetailScheduleScreen extends HookConsumerWidget {
  final ResponseSchedulesModel? item;

  const DetailScheduleScreen({
    super.key,
    this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedulesManager = ref.read(schedulesProvider.notifier);

    final scheduleState = ref.watch(getScheduleProvider);
    final scheduleManager = ref.read(getScheduleProvider.notifier);

    final delScheduleState = ref.watch(delScheduleProvider);
    final delScheduleManager = ref.read(delScheduleProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scheduleManager.requestScheduleInfo(item?.scheduleId ?? -1);
      });
      return () {
        Future(() {
          scheduleManager.init();
          delScheduleManager.init();
        });
      };
    }, []);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          scheduleState.when(
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
          delScheduleState.when(
            success: (event) {
              Toast.showSuccess(context, Strings.of(context).messageRemoveScheduleSuccess);
              schedulesManager.requestGetSchedules();
              Navigator.of(context).pop();
            },
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [scheduleState, delScheduleState]);

    return BaseScaffold(
      appBar: TopBarIconTitleIcon(
        leadingIsShow: true,
        content: item?.name ?? "",
        suffixIcons: [
          Pair("assets/imgs/icon_edit.svg", () {
            if (scheduleState is Success<ResponseScheduleModel>) {
              Navigator.push(
                context,
                nextSlideHorizontalScreen(
                  RoutingScreen.CreateSchedule.route,
                  parameter: scheduleState.value,
                ),
              );
            }
          }),
          Pair("assets/imgs/icon_trash.svg", () {
            CommonPopup.showPopup(
              context,
              child: PopupDelete(
                onClicked: () {
                  delScheduleManager.removeSchedule(item?.scheduleId ?? -1);
                },
              ),
            );
          }),
        ],
        onBack: () => popPageWrapper(context: context),
      ),
      body: Stack(
        children: [
          if (scheduleState is Failure)
            FailView(onPressed: () => scheduleManager.requestScheduleInfo(item?.scheduleId ?? -1))
          else if (scheduleState is Success<ResponseScheduleModel>)
            _ScheduleContent(items: scheduleState.value.playlists),
          if (scheduleState is Loading || delScheduleState is Loading) const LoadingView(),
        ],
      ),
    );
  }
}

class _ScheduleContent extends StatelessWidget {
  final List<ResponsePlaylistsModel>? items;

  const _ScheduleContent({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return !CollectionUtil.isNullorEmpty(items)
        ? ListView.separated(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 80),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) {
              return const DividerVertical(
                marginVertical: 24,
                height: 1,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              final item = items![index];

              return Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 140,
                    height: 140,
                    child: LoadImage(
                      url: item.property?.imageUrl,
                      type: ImagePlaceholderType.Large,
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 140,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              if (index == 0)
                                Text(
                                  "* ",
                                  style: getTextTheme(context).s3sb.copyWith(
                                        color: getColorScheme(context).colorSecondary500,
                                      ),
                                ),
                              Expanded(
                                child: Text(
                                  item.name,
                                  style: getTextTheme(context).s3sb.copyWith(
                                        color: getColorScheme(context).colorGray900,
                                      ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                            child: Text(
                              "${Strings.of(context).commonTime} ${item.time?.start ?? ""} ~ ${item.time?.end ?? ""}",
                              style: getTextTheme(context).b3m.copyWith(
                                    color: getColorScheme(context).colorGray900,
                                  ),
                            ),
                          ),
                          Row(
                            children: [
                              Row(
                                children: item.property?.contentTypes?.map(
                                      (e) {
                                        return Container(
                                          margin: const EdgeInsets.only(right: 4.0),
                                          child: _ContentTypeImage(code: e.code),
                                        );
                                      },
                                    ).toList() ??
                                    [],
                              ),
                              if (item.property?.count != null)
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    Strings.of(context).count_pages(item.property?.count ?? 0),
                                    style: getTextTheme(context).c1sb.copyWith(
                                          color: getColorScheme(context).colorGray500,
                                        ),
                                  ),
                                )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
            itemCount: items!.length,
          )
        : const EmptyView(
            type: BlankMessageType.NEW_SCHEDULE,
            onPressed: null,
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
      width: 20,
      height: 20,
      color: getColorScheme(context).colorGray500,
    );
  }
}
