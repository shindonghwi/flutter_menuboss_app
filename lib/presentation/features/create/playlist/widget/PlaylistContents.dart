import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/presentation/components/blank/BlankMessage.dart';

import 'PlaylistContentItem.dart';

class PlaylistContents extends HookWidget {
  const PlaylistContents({super.key});

  @override
  Widget build(BuildContext context) {
    final isEmpty = false;
    final items = useState(List.generate(10, (index) => index));

    return isEmpty
        ? BlankMessage(
            type: BlankMessageType.ADD_CONTENT,
            onPressed: () {},
          )
        : ValueListenableBuilder<List<int>>(
            valueListenable: items,
            builder: (context, itemsValue, child) {
              return ReorderableListView(
                children: itemsValue
                    .map(
                      (item) => Material(
                        key: ValueKey(item),
                        color: Colors.transparent,
                        child: PlaylistContentItem(item: item),
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
