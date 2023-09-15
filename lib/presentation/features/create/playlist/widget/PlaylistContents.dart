import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/blank/BlankMessage.dart';

import 'PlaylistContentItem.dart';

class PlaylistContents extends HookWidget {
  const PlaylistContents({super.key});

  @override
  Widget build(BuildContext context) {
    final isEmpty = true;
    final items = useState(List.generate(10, (index) => index));

    return isEmpty
        ? Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: BlankMessage(
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
        : ValueListenableBuilder<List<int>>(
            valueListenable: items,
            builder: (context, itemsValue, child) {
              return ReorderableListView(
                physics: const NeverScrollableScrollPhysics(),
                children: itemsValue
                    .map(
                      (item) => Container(
                        key: ValueKey(item),
                        child: PlaylistContentItem(item: item, items: items)
                      ),
                    )
                    .toList(),
                onReorder: (int oldIndex, int newIndex) {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  final item = itemsValue.removeAt(oldIndex);
                  itemsValue.insert(newIndex, item);
                  items.value = List.from(itemsValue); // Trigger an update
                },
              );
            },
          );
  }
}

