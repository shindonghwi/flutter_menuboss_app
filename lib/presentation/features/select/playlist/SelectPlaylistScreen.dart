import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistModel.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistsModel.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/components/checkbox/checkbox/BasicBorderCheckBox.dart';
import 'package:menuboss/presentation/components/loader/LoadImage.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/components/utils/ClickableScale.dart';
import 'package:menuboss/presentation/components/view_state/EmptyView.dart';
import 'package:menuboss/presentation/components/view_state/FailView.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import '../../../components/view_state/LoadingView.dart';
import 'provider/GetSelectPlaylistProvider.dart';

class SelectPlaylistScreen extends HookConsumerWidget {
  final List<int> playlistIds;

  const SelectPlaylistScreen({
    super.key,
    this.playlistIds = const [],
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistItems = useState<List<ResponsePlaylistsModel>?>(null);
    final playlistState = ref.watch(GetSelectPlaylistProvider);
    final playlistProvider = ref.read(GetSelectPlaylistProvider.notifier);
    ValueNotifier<ResponsePlaylistsModel?> selectedPlaylist = useState(null);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        playlistProvider.init(playlistIds);
        playlistProvider.requestPlaylists();
      });
      return null;
    }, []);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          playlistState.when(
            success: (event) => playlistItems.value = event.value,
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [playlistState]);

    return BaseScaffold(
      appBar: TopBarIconTitleNone(
        content: getAppLocalizations(context).select_playlist_title,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            if (playlistState is Failure)
              FailView(onPressed: () => playlistProvider.requestPlaylists())
            else if (playlistItems.value != null)
              _PlaylistContent(items: playlistItems.value!, selectedPlaylist: selectedPlaylist)
            else if (playlistState is Success<List<ResponsePlaylistsModel>>)
              _PlaylistContent(items: playlistState.value, selectedPlaylist: selectedPlaylist),
            if (playlistState is Loading) const LoadingView(),
          ],
        ),
      ),
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
        ? Stack(
            children: [
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
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
                            Row(
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: LoadImage(
                                    url: data.property?.imageUrl ?? "",
                                    type: ImagePlaceholderType.Normal,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.name,
                                        style: getTextTheme(context).b2sb.copyWith(
                                              color: getColorScheme(context).colorGray900,
                                            ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                                        child: Text(
                                          "Updated: ${data.updatedAt}",
                                          style: getTextTheme(context).c1m.copyWith(
                                                color: getColorScheme(context).colorGray500,
                                              ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          if (!CollectionUtil.isNullorEmpty(data.property?.contentTypes))
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
                                                "${data.property?.count ?? 0} pages",
                                                style: getTextTheme(context).c1m.copyWith(
                                                      color: getColorScheme(context).colorGray500,
                                                    ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
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
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: getMediaQuery(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
                  child: PrimaryFilledButton.mediumRound8(
                    content: getAppLocalizations(context).common_done,
                    isActivated: selectedPlaylist.value != null,
                    onPressed: () {
                      items.removeWhere((element) => selectedPlaylist.value?.playlistId == element.playlistId);
                      Navigator.of(context).pop(selectedPlaylist.value);
                    },
                  ),
                ),
              )
            ],
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
