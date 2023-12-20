import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistsModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/features/main/playlists/provider/PlaylistProvider.dart';
import 'package:menuboss/presentation/features/main/playlists/widget/PlaylistItem.dart';
import 'package:menuboss_common/components/appbar/TopBarTitle.dart';
import 'package:menuboss_common/components/button/FloatingPlusButton.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/utils/ClickableScale.dart';
import 'package:menuboss_common/components/view_state/EmptyView.dart';
import 'package:menuboss_common/components/view_state/FailView.dart';
import 'package:menuboss_common/components/view_state/LoadingView.dart';
import 'package:menuboss_common/components/view_state/LoadingView.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/strings.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/UiState.dart';
import 'package:menuboss_common/utils/UiState.dart';


class PlaylistsScreens extends HookConsumerWidget {
  const PlaylistsScreens({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistState = ref.watch(playListProvider);
    final playlistManager = ref.read(playListProvider.notifier);

    useEffect(() {
      return () {
        Future(() {
          playlistManager.init();
        });
      };
    }, []);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          playlistState.when(
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
        });
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        handleUiStateChange();
      });
      return null;
    }, [playlistState]);

    return SafeArea(
      child: Column(
        children: [
          TopBarTitle(
            content: Strings.of(context).mainNavigationMenuPlaylists,
          ),
          Expanded(
            child: Stack(
              children: [
                if (playlistState is Failure)
                  FailView(onPressed: () => playlistManager.requestGetPlaylists())
                else if (playlistState is Success<List<ResponsePlaylistsModel>>)
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
  final List<ResponsePlaylistsModel> items;

  const _PlaylistContentList({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistManager = ref.read(playListProvider.notifier);

    void goToCreatePlaylist() async {
      Navigator.push(
        context,
        nextSlideVerticalScreen(
          RoutingScreen.CreatePlaylist.route,
        ),
      );
    }

    void goToDetailPlaylist(ResponsePlaylistsModel item) async {
      Navigator.push(
        context,
        nextSlideHorizontalScreen(
          RoutingScreen.DetailPlaylist.route,
          parameter: item,
        ),
      );
    }

    return items.isNotEmpty
        ? Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  playlistManager.requestGetPlaylists(delay: 300);
                },
                color: getColorScheme(context).colorPrimary500,
                backgroundColor: getColorScheme(context).white,
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ClickableScale(
                      child: PlaylistItem(item: item),
                      onPressed: () => goToDetailPlaylist(item),
                    );
                  },
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.only(bottom: 16, right: 24),
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
