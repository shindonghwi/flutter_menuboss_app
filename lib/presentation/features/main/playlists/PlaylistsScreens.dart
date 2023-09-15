import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/appbar/TopBarTitle.dart';
import 'package:menuboss/presentation/components/blank/BlankMessage.dart';
import 'package:menuboss/presentation/components/button/FloatingButton.dart';
import 'package:menuboss/presentation/components/loading/LoadingView.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/features/main/playlists/provider/PlaylistProvider.dart';
import 'package:menuboss/presentation/features/main/playlists/widget/PlaylistItem.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class PlaylistsScreens extends HookConsumerWidget {
  const PlaylistsScreens({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlist = useState<List<ResponsePlaylistModel>?>(null);
    final playlistState = ref.watch(PlayListProvider);
    final playlistProvider = ref.read(PlayListProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        playlistProvider.requestGetPlaylists();
      });
      return null;
    }, []);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          playlistState.when(
            success: (event) {
              playlist.value = event.value;
            },
            failure: (event) => ToastUtil.errorToast(event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [playlistState]);

    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              TopBarTitle(content: getAppLocalizations(context).main_navigation_menu_playlists),
              playlist.value == null
                  ? playlistState is Success<List<ResponsePlaylistModel>>
                      ? _PlaylistContentList(items: playlistState.value)
                      : const SizedBox()
                  : _PlaylistContentList(items: playlist.value!),
            ],
          ),
          if (playlistState is Loading) const LoadingView(),
        ],
      ),
    );
  }
}

class _PlaylistContentList extends HookConsumerWidget {
  final List<ResponsePlaylistModel> items;

  const _PlaylistContentList({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController(keepScrollOffset: true);

    void goToCreatePlaylist() {
      Navigator.push(
        context,
        nextSlideVerticalScreen(
          RoutingScreen.CreatePlaylist.route,
        ),
      );
    }

    return items.isNotEmpty
        ? Expanded(
            child: Stack(
              children: [
                ListView.builder(
                  controller: scrollController,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return PlayListItem(item: item);
                  },
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  margin: const EdgeInsets.only(bottom: 32, right: 24),
                  child: FloatingPlusButton(
                    onPressed: () {
                      goToCreatePlaylist();
                    },
                  ),
                )
              ],
            ),
          )
        : Expanded(
            child: BlankMessage(
              type: BlankMessageType.NEW_PLAYLIST,
              onPressed: () => goToCreatePlaylist(),
            ),
          );
  }
}
