import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/appbar/TopBarTitle.dart';
import 'package:menuboss/presentation/components/blank/BlankMessage.dart';
import 'package:menuboss/presentation/components/button/FloatingButton.dart';
import 'package:menuboss/presentation/components/utils/ClickableScale.dart';
import 'package:menuboss/presentation/features/main/playlists/model/PlayListModel.dart';
import 'package:menuboss/presentation/features/main/playlists/provider/PlayListProvider.dart';
import 'package:menuboss/presentation/features/main/playlists/widget/PlayListItem.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/CustomHook.dart';

class PlayListsScreens extends HookConsumerWidget {
  const PlayListsScreens({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listKey = useState(CustomHook.useGlobalKey<AnimatedListState>()).value;
    final items = ref.watch(playListProvider(listKey));
    final listProvider = ref.read(playListProvider(listKey).notifier);

    useEffect(() {
      void generateItems(int count) {
        for (int i = 0; i < count; i++) {
          listProvider.addItem(PlayListModel(null, "New folder $i", "2021.09.08"));
        }
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        generateItems(10);
      });
      return null;
    }, []);

    void goToApplyToScreen(){
      Navigator.push(
        context,
        nextSlideScreen(RoutingScreen.ApplyScreen.route),
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
                        key: listProvider.listKey,
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
                            goToApplyToScreen();
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
