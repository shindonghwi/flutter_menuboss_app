import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/SimpleMediaContentModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/view_state/EmptyView.dart';
import 'package:menuboss/presentation/features/create/playlist/provider/PlaylistSaveInfoProvider.dart';
import 'package:menuboss/presentation/features/media_content/provider/MediaContentsCartProvider.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';

import 'PlaylistContentItem.dart';

class PlaylistContents extends HookConsumerWidget {
  const PlaylistContents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saveProvider = ref.read(PlaylistSaveInfoProvider.notifier);
    final List<SimpleMediaContentModel> contentItems = ref.watch(MediaContentsCartProvider);
    final items = useState<List<SimpleMediaContentModel>>([]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        items.value = [...contentItems];
        saveProvider.changeContents(items.value);
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
                  nextSlideHorizontalScreen(
                    RoutingScreen.MediaContent.route,
                    fullScreen: true,
                  ),
                );
              },
            ),
          )
        : Expanded(
            child: ReorderableListView(
              physics: const NeverScrollableScrollPhysics(),
              children: items.value.map(
                (item) {
                  final index = contentItems.indexOf(item);
                  return Container(
                    key: ValueKey(item.id),
                    child: PlaylistContentItem(index: index, item: item),
                  );
                },
              ).toList(),
              onReorder: (int oldIndex, int newIndex) {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }
                final item = items.value.removeAt(oldIndex);
                items.value.insert(newIndex, item);
                items.value = [...items.value];
                saveProvider.changeContents(items.value);
              },
            ),
          );
  }
}
