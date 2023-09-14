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
          if (playlistState is Success<List<ResponsePlaylistModel>>)
            Column(
              children: [
                TopBarTitle(content: getAppLocalizations(context).main_navigation_menu_playlists),
                _PlaylistContentList(items: playlistState.value)
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
    final listKey = GlobalKey<AnimatedListState>();

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
                AnimatedList(
                  key: listKey,
                  initialItemCount: items.length,
                  padding: const EdgeInsets.only(bottom: 80),
                  itemBuilder: (context, index, animation) {
                    final item = items[index];
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, -0.15),
                        end: Offset.zero,
                      ).animate(animation),
                      child: FadeTransition(
                        opacity: animation,
                        child: PlayListItem(item: item, listKey: listKey),
                      ),
                    );
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
