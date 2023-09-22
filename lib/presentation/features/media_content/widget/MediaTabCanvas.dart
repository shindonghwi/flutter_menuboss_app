import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/SimpleMediaContentModel.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/features/media_content/provider/MediaContentsCanvasProvider.dart';
import 'package:menuboss/presentation/model/UiState.dart';

import 'MediaItemAdd.dart';

class MediaTabCanvas extends HookConsumerWidget {
  const MediaTabCanvas({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    final mediaContents = useState<List<SimpleMediaContentModel>?>(null);
    final mediaContentsState = ref.watch(MediaContentsCanvasProvider);
    final mediaContentsProvider = ref.read(MediaContentsCanvasProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        mediaContentsProvider.requestGetCanvases();
      });
      return null;
    }, []);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          mediaContentsState.when(
            success: (event) {
              mediaContents.value = event.value;
            },
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [mediaContentsState]);

    return Stack(
      children: [
        mediaContents.value == null
            ? mediaContentsState is Success<List<SimpleMediaContentModel>>
                ? _SimpleMediaList(items: mediaContentsState.value)
                : const SizedBox()
            : _SimpleMediaList(items: mediaContents.value!)
      ],
    );
  }
}

class _SimpleMediaList extends HookConsumerWidget {
  final List<SimpleMediaContentModel> items;

  const _SimpleMediaList({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return MediaItemAdd(item: items[index], onFolderTap: () {});
        },
      ),
    );
  }
}
