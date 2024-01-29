import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistsModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss_common/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss_common/components/button/PrimaryFilledButton.dart';
import 'package:menuboss_common/components/checkbox/checkbox/BasicBorderCheckBox.dart';
import 'package:menuboss_common/components/loader/LoadImage.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/components/placeholder/PlaceholderType.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/components/utils/ClickableScale.dart';
import 'package:menuboss_common/components/view_state/EmptyView.dart';
import 'package:menuboss_common/components/view_state/FailView.dart';
import 'package:menuboss_common/components/view_state/LoadingView.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/CollectionUtil.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/UiState.dart';

import 'provider/GetSelectPlaylistProvider.dart';

class SelectedPlaylistInfo {
  final int playlistId;
  final String playlistName;
  final String? start;
  final String? end;
  final List<int> playlistIds;

  SelectedPlaylistInfo({
    required this.playlistId,
    required this.playlistName,
    required this.start,
    required this.end,
    required this.playlistIds,
  });
}

class SelectPlaylistScreen extends HookConsumerWidget {
  final SelectedPlaylistInfo? selectedPlaylistInfo;

  const SelectPlaylistScreen({
    super.key,
    this.selectedPlaylistInfo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistState = ref.watch(getSelectPlaylistProvider);
    final playlistProvider = ref.read(getSelectPlaylistProvider.notifier);
    ValueNotifier<ResponsePlaylistsModel?> selectedPlaylist = useState(null);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        playlistProvider.init(selectedPlaylistInfo?.playlistIds);
        playlistProvider.requestPlaylists();
      });
      return null;
    }, []);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          playlistState.when(
            success: (event) async {
              for (var element in event.value) {
                if (element.playlistId == selectedPlaylistInfo?.playlistId) {
                  selectedPlaylist.value = element;
                  break;
                }
              }
            },
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [playlistState]);

    return BaseScaffold(
      appBar: TopBarIconTitleNone(
        content: getString(context).selectPlaylistTitle,
        onBack: () => popPageWrapper(context: context),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            if (playlistState is Failure)
              FailView(onPressed: () => playlistProvider.requestPlaylists())
            else if (playlistState is Success<List<ResponsePlaylistsModel>>)
              _PlaylistContent(items: playlistState.value, selectedPlaylist: selectedPlaylist),
            if (playlistState is Loading) const LoadingView(),
          ],
        ),
      ),
      bottomNavigationBar:
          playlistState is Success<List<ResponsePlaylistsModel>> && playlistState.value.isNotEmpty
              ? SafeArea(
                  child: Container(
                    width: getMediaQuery(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
                    child: PrimaryFilledButton.largeRound8(
                      content: getString(context).commonDone,
                      isActivated: selectedPlaylist.value != null,
                      onPressed: () {
                        Navigator.of(context).pop(selectedPlaylist.value);
                      },
                    ),
                  ),
                )
              : null,
    );
  }
}

class _PlaylistContent extends HookWidget {
  final List<ResponsePlaylistsModel> items;
  final ValueNotifier<ResponsePlaylistsModel?> selectedPlaylist;

  const _PlaylistContent({
    super.key,
    required this.items,
    required this.selectedPlaylist,
  });

  @override
  Widget build(BuildContext context) {
    return items.isNotEmpty
        ? ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 0);
            },
            itemBuilder: (BuildContext context, int index) {
              final data = items[index];
              return ClickableScale(
                onPressed: () {
                  if (selectedPlaylist.value?.playlistId == data.playlistId) {
                    selectedPlaylist.value = null;
                    return;
                  }
                  selectedPlaylist.value = data;
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: LoadImage(
                                  url: data.property?.imageUrl ?? "",
                                  type: ImagePlaceholderType.Size_80,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.name,
                                        style: getTextTheme(context).b2m.copyWith(
                                              color: getColorScheme(context).colorGray900,
                                            ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                                        child: Text(
                                          "${getString(context).commonUpdated} : ${data.updatedDate}",
                                          style: getTextTheme(context).c1m.copyWith(
                                                color: getColorScheme(context).colorGray500,
                                              ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          if (!CollectionUtil.isNullorEmpty(
                                              data.property?.contentTypes))
                                            Row(
                                              children: data.property!.contentTypes!.map((e) {
                                                return Container(
                                                  margin: const EdgeInsets.only(right: 4),
                                                  child: _ContentTypeImage(code: e.code),
                                                );
                                              }).toList(),
                                            ),
                                          if (data.property?.count != null)
                                            Padding(
                                              padding: const EdgeInsets.only(left: 4.0),
                                              child: Text(
                                                getString(context)
                                                    .countPages(data.property?.count ?? 0),
                                                style: getTextTheme(context).c1m.copyWith(
                                                      color: getColorScheme(context).colorGray500,
                                                    ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        IgnorePointer(
                          child: BasicBorderCheckBox(
                            isChecked: selectedPlaylist.value?.playlistId == data.playlistId,
                            onChange: null,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: items.length,
          )
        : const EmptyView(
            type: BlankMessageType.NEW_PLAYLIST,
            onPressed: null,
          );
  }
}

class _ContentTypeImage extends StatelessWidget {
  final String code;

  const _ContentTypeImage({
    super.key,
    required this.code,
  });

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
