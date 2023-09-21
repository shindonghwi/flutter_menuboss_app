import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistModel.dart';
import 'package:menuboss/data/models/schedule/ResponseScheduleModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleIcon.dart';
import 'package:menuboss/presentation/components/divider/DividerVertical.dart';
import 'package:menuboss/presentation/components/loader/LoadImage.dart';
import 'package:menuboss/presentation/components/loading/LoadingView.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/components/popup/CommonPopup.dart';
import 'package:menuboss/presentation/components/popup/PopupDelete.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/features/detail/schedule/provider/DelScheduleProvider.dart';
import 'package:menuboss/presentation/features/detail/schedule/provider/GetScheduleProvider.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/dto/Pair.dart';

class DetailScheduleScreen extends HookConsumerWidget {
  final ResponseScheduleModel? item;

  const DetailScheduleScreen({
    super.key,
    this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleState = ref.watch(GetScheduleProvider);
    final delScheduleState = ref.watch(DelScheduleProvider);

    final scheduleProvider = ref.read(GetScheduleProvider.notifier);
    final delScheduleProvider = ref.read(DelScheduleProvider.notifier);
    final scheduleItem = useState<ResponseScheduleModel?>(null);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scheduleProvider.init();
        delScheduleProvider.init();
        if (item?.scheduleId == null) return;
        scheduleProvider.requestScheduleInfo(item?.scheduleId ?? -1);
      });
      return null;
    }, []);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          scheduleState.when(
            success: (event) => scheduleItem.value = event.value,
            failure: (event) => ToastUtil.errorToast(event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [scheduleState]);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          delScheduleState.when(
            success: (event) {
              delScheduleProvider.init();
              Navigator.of(context).pop(true);
            },
            failure: (event) => ToastUtil.errorToast(event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [delScheduleState]);

    return BaseScaffold(
      appBar: TopBarIconTitleIcon(
        leadingIsShow: true,
        content: item?.name ?? "",
        suffixIcons: [
          Pair("assets/imgs/icon_edit.svg", () async {
            try {
              final isUpdated = await Navigator.push(
                context,
                nextSlideHorizontalScreen(
                  RoutingScreen.CreateSchedule.route,
                  parameter: scheduleItem.value,
                ),
              );
              if (isUpdated) {
                Navigator.of(context).pop(true);
              }
            } catch (e) {
              debugPrint(e.toString());
            }
          }),
          Pair("assets/imgs/icon_trash.svg", () {
            CommonPopup.showPopup(
              context,
              child: PopupDelete(
                onClicked: () {
                  delScheduleProvider.removeSchedule(item?.scheduleId ?? -1);
                },
              ),
            );
          }),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              scheduleItem.value == null
                  ? scheduleState is Success<ResponseScheduleModel>
                      ? _ScheduleContent(items: scheduleState.value.playlists)
                      : const SizedBox()
                  : _ScheduleContent(items: scheduleItem.value?.playlists),
            ],
          ),
          if (scheduleState is Loading || delScheduleState is Loading) const LoadingView(),
        ],
      ),
    );
  }
}

class _ScheduleContent extends StatelessWidget {
  final List<ResponsePlaylistModel>? items;

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
                                  "*",
                                  style: getTextTheme(context).s2b.copyWith(
                                        color: getColorScheme(context).colorSecondary500,
                                      ),
                                ),
                              Text(
                                item.name,
                                style: getTextTheme(context).s2b.copyWith(
                                      color: getColorScheme(context).colorGray900,
                                    ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                            child: Text(
                              "${getAppLocalizations(context).common_time} ${item.time?.start ?? ""} ~ ${item.time?.end ?? ""}",
                              style: getTextTheme(context).b3sb.copyWith(
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
                                    "${item.property?.count ?? 0} pages",
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
        : const SizedBox();
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
      width: 20,
      height: 20,
      colorFilter: ColorFilter.mode(
        getColorScheme(context).colorGray500,
        BlendMode.srcIn,
      ),
    );
  }
}
