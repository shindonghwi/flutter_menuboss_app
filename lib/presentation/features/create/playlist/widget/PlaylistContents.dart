import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/SimpleMediaContentModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/view_state/EmptyView.dart';
import 'package:menuboss/presentation/features/create/playlist/provider/PlaylistSaveInfoProvider.dart';
import 'package:menuboss/presentation/features/media_content/provider/MediaContentsCartProvider.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import 'PlaylistContentItem.dart';

class PlaylistContents extends HookConsumerWidget {
  const PlaylistContents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaCartManger = ref.read(mediaContentsCartProvider.notifier);
    final saveManager = ref.read(playlistSaveInfoProvider.notifier);
    final List<SimpleMediaContentModel> contentItems = ref.watch(mediaContentsCartProvider);
    final items = useState<List<SimpleMediaContentModel>>([]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // 아이템 순서 셋팅 ( 중복아이템이 들어올수있어서, 순서대로 인덱스를 정한다. )
        items.value = [...contentItems.asMap().entries.map((e) => e.value.copyWith(index: e.key))];
        saveManager.changeContents(items.value);
      });
      return null;
    }, [contentItems]);

    return CollectionUtil.isNullorEmpty(contentItems)
        ? Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: EmptyView(
              type: BlankMessageType.ADD_CONTENT,
              onPressed: () {
                Navigator.push(
                  context,
                  nextSlideVerticalScreen(
                    RoutingScreen.MediaContent.route,
                    fullScreen: true,
                  ),
                );
              },
            ),
          )
        : Expanded(
            child: ReorderableListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: items.value.map((item) {
                return Container(
                  key: ValueKey(item.index),
                  child: PlaylistContentItem(index: item.index ?? -1, item: item),
                );
              }).toList(),
              onReorder: (int oldIndex, int newIndex) {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }
                final item = items.value.removeAt(oldIndex);
                items.value.insert(newIndex, item);
                items.value = [...items.value];
                mediaCartManger.changeItems(items.value);
                saveManager.changeContents(items.value);
              },
              proxyDecorator: (child, index, animation) {
                return Container(
                  decoration: BoxDecoration(
                    color: getColorScheme(context).colorGray50,
                  ),
                  child: child,
                );
              },
            )

    );
  }
}
