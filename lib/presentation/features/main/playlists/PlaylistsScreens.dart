import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/appbar/TopBarTitle.dart';
import 'package:menuboss/presentation/components/button/FloatingButton.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/ClickableScale.dart';
import 'package:menuboss/presentation/components/view_state/EmptyView.dart';
import 'package:menuboss/presentation/components/view_state/FailView.dart';
import 'package:menuboss/presentation/features/main/playlists/provider/PlaylistProvider.dart';
import 'package:menuboss/presentation/features/main/playlists/widget/PlaylistItem.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import '../../../components/view_state/LoadingView.dart';

class PlaylistsScreens extends HookConsumerWidget {
  const PlaylistsScreens({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistState = ref.watch(PlayListProvider);
    final playlistProvider = ref.read(PlayListProvider.notifier);
    final playlist = useState<List<ResponsePlaylistModel>?>(null);

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
              playlistProvider.init();
            },
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [playlistState]);

    return SafeArea(
      child: Column(
        children: [
          TopBarTitle(
            content: getAppLocalizations(context).main_navigation_menu_playlists,
          ),
          Expanded(
            child: Stack(
              children: [
                if (playlistState is Failure)
                  FailView(onPressed: () => playlistProvider.requestGetPlaylists())
                else if (playlist.value != null)
                  _PlaylistContentList(items: playlist.value!)
                else if (playlistState is Success<List<ResponsePlaylistModel>>)
                  _PlaylistContentList(items: playlistState.value),
                if (playlistState is Loading) const LoadingView(),
              ],
            ),
          ),
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
    final playlistProvider = ref.read(PlayListProvider.notifier);

    void goToCreatePlaylist() async {
      try {
        bool isRegistered = await Navigator.push(
          context,
          nextSlideVerticalScreen(
            RoutingScreen.CreatePlaylist.route,
          ),
        );
        if (isRegistered) {
          playlistProvider.requestGetPlaylists();
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    void goToDetailPlaylist(ResponsePlaylistModel item) async {
      try {
        final isChanged = await Navigator.push(
          context,
          nextSlideHorizontalScreen(
            RoutingScreen.DetailPlaylist.route,
            parameter: item,
          ),
        );

        if (isChanged) {
          playlistProvider.requestGetPlaylists();
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    return items.isNotEmpty
        ? Stack(
            children: [
              ListView.builder(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
                physics: const BouncingScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ClickableScale(
                    child: PlaylistItem(item: item),
                    onPressed: () => goToDetailPlaylist(item),
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
          )
        : EmptyView(
            type: BlankMessageType.NEW_PLAYLIST,
            onPressed: () => goToCreatePlaylist(),
          );
  }
}
