import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleIcon.dart';
import 'package:menuboss/presentation/components/checkbox/radio/BasicBorderRadioButton.dart';
import 'package:menuboss/presentation/components/divider/DividerVertical.dart';
import 'package:menuboss/presentation/components/loader/LoadImage.dart';
import 'package:menuboss/presentation/components/loading/LoadingView.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/components/popup/CommonPopup.dart';
import 'package:menuboss/presentation/components/popup/PopupDelete.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/features/create/playlist/provider/PlaylistSaveInfoProvider.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';
import 'package:menuboss/presentation/utils/dto/Pair.dart';

import 'provider/DelEditPlaylistProvider.dart';
import 'provider/GetEditPlaylistProvider.dart';

class DetailPlaylistScreen extends HookConsumerWidget {
  final ResponsePlaylistModel? item;

  const DetailPlaylistScreen({
    super.key,
    this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editPlaylistState = ref.watch(GetEditPlaylistProvider);
    final delEditPlaylistState = ref.watch(DelEditPlaylistProvider);

    final editPlaylistProvider = ref.read(GetEditPlaylistProvider.notifier);
    final delEditPlaylistProvider = ref.read(DelEditPlaylistProvider.notifier);
    final editPlaylist = useState<ResponsePlaylistModel?>(null);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        editPlaylistProvider.init();
        delEditPlaylistProvider.init();
        if (item?.playlistId == null) return;
        editPlaylistProvider.requestPlaylistInfo(item?.playlistId ?? -1);
      });
      return null;
    }, []);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          editPlaylistState.when(
            success: (event) => editPlaylist.value = event.value,
            failure: (event) => ToastUtil.errorToast(event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [editPlaylistState]);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          delEditPlaylistState.when(
            success: (event) {
              delEditPlaylistProvider.init();
              Navigator.of(context).pop(true);
            },
            failure: (event) => ToastUtil.errorToast(event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [delEditPlaylistState]);

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
                  RoutingScreen.CreatePlaylist.route,
                  parameter: editPlaylist.value,
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
                  delEditPlaylistProvider.removePlaylist(item?.playlistId ?? -1);
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
              editPlaylist.value == null
                  ? editPlaylistState is Success<ResponsePlaylistModel>
                      ? _PlaylistContent(item: editPlaylistState.value)
                      : const SizedBox()
                  : _PlaylistContent(item: editPlaylist.value!),
            ],
          ),
          if (editPlaylistState is Loading || delEditPlaylistState is Loading) const LoadingView(),
        ],
      ),
    );
  }
}

class _PlaylistContent extends StatelessWidget {
  final ResponsePlaylistModel item;

  const _PlaylistContent({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Settings(item: item),
        const DividerVertical(marginVertical: 0),
        _TotalDuration(item: item),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 0);
          },
          itemBuilder: (BuildContext context, int index) {
            final data = item.contents?[index];
            return SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: LoadImage(
                        url: data?.property.imageUrl ?? "",
                        type: ImagePlaceholderType.Small,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _ContentTypeImage(
                                  code: data?.type.code ?? "",
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Text(
                                      data?.name ?? "",
                                      style: getTextTheme(context).b2sb.copyWith(
                                            color: getColorScheme(context).colorGray900,
                                          ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                StringUtil.formatDuration(data?.duration ?? 0),
                                style: getTextTheme(context).c1m.copyWith(
                                      color: getColorScheme(context).colorGray500,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: item.contents?.length ?? 0,
        ),
      ],
    );
  }
}

class _Settings extends StatelessWidget {
  final ResponsePlaylistModel item;

  const _Settings({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {

    debugPrint("item.property?.direction?.name.toLowerCase() : ${item.property?.direction?.code.toLowerCase()}");
    debugPrint("item.property?.direction?.name.toLowerCase() : ${item.property?.fill?.code.toLowerCase()}");

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            getAppLocalizations(context).common_settings,
            style: getTextTheme(context).b3b.copyWith(
                  color: getColorScheme(context).colorGray500,
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: _SettingContents(
              directionType: item.property?.direction?.name.toLowerCase() == "horizontal"
                  ? PlaylistSettingType.Horizontal
                  : PlaylistSettingType.Vertical,
              scaleType:
                  item.property?.fill?.code.toLowerCase() == "fit" ? PlaylistSettingType.Fit : PlaylistSettingType.Fill,
            ),
          ),
        ],
      ),
    );
  }
}

class _TotalDuration extends StatelessWidget {
  final ResponsePlaylistModel item;

  const _TotalDuration({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: [
          Text(
            getAppLocalizations(context).common_total_duration,
            style: getTextTheme(context).b3b.copyWith(
                  color: getColorScheme(context).colorGray500,
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              StringUtil.formatDuration(
                item.contents?.map((e) => e.duration).reduce(
                      (value, element) {
                        return value + element;
                      },
                    ) ??
                    0,
              ),
              style: getTextTheme(context).b3sb.copyWith(
                    color: getColorScheme(context).colorGray900,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingContents extends HookWidget {
  final PlaylistSettingType directionType;
  final PlaylistSettingType scaleType;

  const _SettingContents({
    super.key,
    required this.directionType,
    required this.scaleType,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _SettingSelectableIcon(
            iconPath: directionType == PlaylistSettingType.Horizontal
                ? "assets/imgs/icon_horizontal_line.svg"
                : "assets/imgs/icon_vertical_line.svg",
            iconText: directionType == PlaylistSettingType.Horizontal
                ? getAppLocalizations(context).common_horizontal
                : getAppLocalizations(context).common_vertical,
            isChecked: true,
          ),
        ),
        Container(
          width: 1,
          height: 24,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          color: getColorScheme(context).colorGray300,
        ),
        Expanded(
          child: _SettingSelectableIcon(
            iconPath:
                scaleType == PlaylistSettingType.Fit ? "assets/imgs/icon_fit.svg" : "assets/imgs/icon_fill.svg",
            iconText: scaleType == PlaylistSettingType.Fit
                ? getAppLocalizations(context).common_fit
                : getAppLocalizations(context).common_fill,
            isChecked: true,
          ),
        ),
      ],
    );
  }
}

class _SettingSelectableIcon extends HookWidget {
  final bool isChecked;
  final String iconPath;
  final String iconText;

  const _SettingSelectableIcon({
    super.key,
    required this.isChecked,
    required this.iconPath,
    required this.iconText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                iconPath,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  getColorScheme(context).colorGray900,
                  BlendMode.srcIn,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  iconText,
                  style: getTextTheme(context).b3sb.copyWith(
                        color: getColorScheme(context).colorGray900,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 24,
            height: 24,
            child: BasicBorderRadioButton(
              isChecked: isChecked,
              onChange: null,
            ),
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
      width: 20,
      height: 20,
      colorFilter: ColorFilter.mode(
        getColorScheme(context).colorGray900,
        BlendMode.srcIn,
      ),
    );
  }
}
