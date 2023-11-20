import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistModel.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistsModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleIcon.dart';
import 'package:menuboss/presentation/components/button/NeutralLineButton.dart';
import 'package:menuboss/presentation/components/divider/DividerVertical.dart';
import 'package:menuboss/presentation/components/loader/LoadImage.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/components/popup/CommonPopup.dart';
import 'package:menuboss/presentation/components/popup/PopupDelete.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/components/view_state/EmptyView.dart';
import 'package:menuboss/presentation/components/view_state/FailView.dart';
import 'package:menuboss/presentation/features/create/playlist/provider/PlaylistSaveInfoProvider.dart';
import 'package:menuboss/presentation/features/preview/provider/PreviewListProvider.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';
import 'package:menuboss/presentation/utils/dto/Pair.dart';

import '../../../components/view_state/LoadingView.dart';
import '../../main/playlists/provider/PlaylistProvider.dart';
import 'provider/DelPlaylistProvider.dart';
import 'provider/DetailPreviewItemProcessProvider.dart';
import 'provider/GetPlaylistProvider.dart';

class DetailPlaylistScreen extends HookConsumerWidget {
  final ResponsePlaylistsModel? item;

  const DetailPlaylistScreen({
    super.key,
    this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistsManager = ref.read(playListProvider.notifier);

    final playlistState = ref.watch(getPlaylistProvider);
    final playlistManager = ref.read(getPlaylistProvider.notifier);

    final delPlaylistState = ref.watch(DelPlaylistProvider);
    final delPlaylistProvider = ref.read(DelPlaylistProvider.notifier);

    final detailPreviewProcessState = ref.watch(detailPreviewItemProcessProvider);
    final detailPreviewProcessManager = ref.read(detailPreviewItemProcessProvider.notifier);

    final previewListManager = ref.read(previewListProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        playlistManager.requestPlaylistInfo(item?.playlistId ?? -1);
      });
      return () {
        Future(() {
          playlistManager.init();
          delPlaylistProvider.init();
        });
      };
    }, []);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          playlistState.when(
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
          delPlaylistState.when(
            success: (event) {
              Toast.showSuccess(context, getAppLocalizations(context).message_remove_playlist_success);
              playlistsManager.requestGetPlaylists();
              Navigator.of(context).pop();
            },
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [playlistState, delPlaylistState]);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          detailPreviewProcessState.when(
            success: (event) {
              final convertedItems = event.value;
              if (CollectionUtil.isNullorEmpty(convertedItems)) {
                Toast.showWarning(context, getAppLocalizations(context).message_add_media_content);
                return;
              }

              previewListManager.changeItems(
                PreviewModel(
                  getPlaylistDirectionTypeFromString(item?.property?.direction),
                  detailPreviewProcessManager.scaleType,
                  convertedItems,
                  convertedItems.map((e) => e.property?.duration?.ceil()).toList(),
                ),
              );
              Navigator.push(
                context,
                nextSlideVerticalScreen(
                  RoutingScreen.PreviewPlaylist.route,
                ),
              );
            },
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [detailPreviewProcessState]);

    return BaseScaffold(
      appBar: TopBarIconTitleIcon(
        leadingIsShow: true,
        content: item?.name ?? "",
        suffixIcons: [
          Pair("assets/imgs/icon_edit.svg", () async {
            if (playlistState is Success<ResponsePlaylistModel>) {
              Navigator.push(
                context,
                nextSlideHorizontalScreen(
                  RoutingScreen.CreatePlaylist.route,
                  parameter: playlistState.value,
                ),
              );
            }
          }),
          Pair("assets/imgs/icon_trash.svg", () {
            CommonPopup.showPopup(
              context,
              child: PopupDelete(
                onClicked: () {
                  delPlaylistProvider.removePlaylist(item?.playlistId ?? -1);
                },
              ),
            );
          }),
        ],
      ),
      body: Stack(
        children: [
          if (playlistState is Failure)
            FailView(onPressed: () => playlistManager.requestPlaylistInfo(item?.playlistId ?? -1))
          else if (playlistState is Success<ResponsePlaylistModel>)
            _PlaylistContent(item: playlistState.value),
          if (playlistState is Loading || delPlaylistState is Loading) const LoadingView(),
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
    return !CollectionUtil.isNullorEmpty(item.contents)
        ? Column(
            children: [
              _Options(item: item),
              const DividerVertical(marginVertical: 0),
              _TotalDuration(item: item),
              Expanded(
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
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
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Row(
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Text(
                              StringUtil.formatDuration(data?.duration ?? 0),
                              style: getTextTheme(context).b3sb.copyWith(
                                    color: getColorScheme(context).colorGray500,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: item.contents?.length ?? 0,
                ),
              ),
            ],
          )
        : const EmptyView(
            type: BlankMessageType.NEW_PLAYLIST,
            onPressed: null,
          );
  }
}

class _Options extends StatelessWidget {
  final ResponsePlaylistModel item;

  const _Options({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            getAppLocalizations(context).common_option,
            style: getTextTheme(context).b3b.copyWith(
                  color: getColorScheme(context).colorGray900,
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: _OptionContents(
              directionType: getPlaylistDirectionTypeFromString(item.property?.direction?.code),
              scaleType: getPlaylistDirectionTypeFromString(item.property?.fill?.code),
            ),
          ),
        ],
      ),
    );
  }
}

class _TotalDuration extends HookConsumerWidget {
  final ResponsePlaylistModel item;

  const _TotalDuration({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailPreviewProcessManager = ref.read(detailPreviewItemProcessProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                getAppLocalizations(context).common_total_duration,
                style: getTextTheme(context).b3b.copyWith(
                      color: getColorScheme(context).colorGray900,
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
                        color: getColorScheme(context).colorGray500,
                      ),
                ),
              ),
            ],
          ),
          NeutralLineButton.smallRound4Icon(
            leftIcon: SvgPicture.asset(
              "assets/imgs/icon_playlists_line.svg",
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                getColorScheme(context).black,
                BlendMode.srcIn,
              ),
            ),
            content: getAppLocalizations(context).common_preview,
            isActivated: true,
            onPressed: () {
              var previewItems = item.contents?.map((e) => e.toMapperMediaContentModel()).toList();
              detailPreviewProcessManager.conversionStart(
                getPlaylistScaleTypeFromString(item.property?.fill?.code),
                previewItems ?? [],
              );
              // 이후 conversionStart가 끝나면 변환된 리스트를 uistate Success에서 관찰 후 이후 프리뷰로 이동한다.
            },
          )
        ],
      ),
    );
  }
}

class _OptionContents extends HookWidget {
  final PlaylistSettingType directionType;
  final PlaylistSettingType scaleType;

  const _OptionContents({
    super.key,
    required this.directionType,
    required this.scaleType,
  });

  @override
  Widget build(BuildContext context) {
    var directionIconPath = "";
    var directionName = "";
    var scaleIconPath = "";
    var scaleIconName = "";

    if (directionType == PlaylistSettingType.Horizontal) {
      directionIconPath = "assets/imgs/icon_horizontal_line.svg";
      directionName = getAppLocalizations(context).common_horizontal;
    } else {
      directionIconPath = "assets/imgs/icon_vertical_line.svg";
      directionName = getAppLocalizations(context).common_vertical;
    }

    if (scaleType == PlaylistSettingType.Fit) {
      scaleIconPath = "assets/imgs/icon_fit.svg";
      scaleIconName = getAppLocalizations(context).common_fit;
    } else if (scaleType == PlaylistSettingType.Fill) {
      scaleIconPath = "assets/imgs/icon_fill_line.svg";
      scaleIconName = getAppLocalizations(context).common_fill;
    } else if (scaleType == PlaylistSettingType.Stretch) {
      scaleIconPath = "assets/imgs/icon_stretch.svg";
      scaleIconName = getAppLocalizations(context).common_stretch;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _OptionPropertyInfo(
          iconPath: directionIconPath,
          iconText: directionName,
          isChecked: true,
        ),
        Container(
          width: 1,
          height: 20,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          color: getColorScheme(context).colorGray300,
        ),
        _OptionPropertyInfo(
          iconPath: scaleIconPath,
          iconText: scaleIconName,
          isChecked: true,
        ),
      ],
    );
  }
}

class _OptionPropertyInfo extends HookWidget {
  final bool isChecked;
  final String iconPath;
  final String iconText;

  const _OptionPropertyInfo({
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
        getColorScheme(context).colorGray900,
        BlendMode.srcIn,
      ),
    );
  }
}
