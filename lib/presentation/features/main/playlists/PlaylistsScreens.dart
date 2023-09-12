import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/appbar/TopBarTitle.dart';
import 'package:menuboss/presentation/components/blank/BlankMessage.dart';
import 'package:menuboss/presentation/components/button/FloatingButton.dart';
import 'package:menuboss/presentation/components/utils/ClickableScale.dart';
import 'package:menuboss/presentation/features/main/playlists/model/PlaylistModel.dart';
import 'package:menuboss/presentation/features/main/playlists/provider/PlaylistProvider.dart';
import 'package:menuboss/presentation/features/main/playlists/widget/PlaylistItem.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class PlaylistsScreens extends HookConsumerWidget {
  const PlaylistsScreens({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listKey = GlobalKey<AnimatedListState>();
    final items = ref.watch(PlayListProvider);
    final listProvider = ref.read(PlayListProvider.notifier);

    useEffect(() {
      void generateItems(int count) {
        for (int i = 0; i < count; i++) {
          listProvider.addItem(PlaylistModel(null, "New folder $i", "2021.09.08"));
        }
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        generateItems(10);
      });
      return null;
    }, []);

    void goToApplyToScreen() {
      Navigator.push(
        context,
        nextSlideScreen(RoutingScreen.ApplyDevice.route),
      );
    }

    void goToCreatePlaylistScreen() {
      Navigator.push(
        context,
        nextFadeInOutScreen(
          RoutingScreen.CreatePlaylist.route,
          fullScreen: true,
        ),
      );
    }

    return SafeArea(
      child: Column(
        children: [
          TopBarTitle(
            content: getAppLocalizations(context).main_navigation_menu_playlists,
          ),
          items.isNotEmpty
              ? Expanded(
                  child: Stack(
                    children: [
                      AnimatedList(
                        key: listKey,
                        initialItemCount: items.length,
                        padding: const EdgeInsets.only(bottom: 80),
                        itemBuilder: (context, index, animation) {
                          final item = items[index];
                          return ClickableScale(
                            onPressed: () {
                              goToApplyToScreen();
                            },
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, -0.15),
                                end: Offset.zero,
                              ).animate(animation),
                              child: FadeTransition(
                                opacity: animation,
                                child: PlayListItem(item: item, listKey: listKey),
                              ),
                            ),
                          );
                        },
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        margin: const EdgeInsets.only(bottom: 32, right: 24),
                        child: FloatingPlusButton(
                          onPressed: () {
                            goToCreatePlaylistScreen();
                          },
                        ),
                      )
                    ],
                  ),
                )
              : Expanded(
                  child: BlankMessage(
                    type: BlankMessageType.NEW_PLAYLIST,
                    onPressed: () {},
                  ),
                ),
        ],
      ),
    );
  }
}
