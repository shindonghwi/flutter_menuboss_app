import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/SimpleMediaContentModel.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/view_state/EmptyView.dart';
import 'package:menuboss/presentation/components/view_state/FailView.dart';
import 'package:menuboss/presentation/components/view_state/LoadingView.dart';
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

    // final mediaContents = useState<List<SimpleMediaContentModel>?>(null);
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
              // mediaContents.value = event.value;
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
        if (mediaContentsState is Failure)
          FailView(onPressed: () => mediaContentsProvider.requestGetCanvases())
        // else if (mediaContents.value != null)
        //   _SimpleMediaList(
        //     items: mediaContents.value!,
        //   )
        else if (mediaContentsState is Success<List<SimpleMediaContentModel>>)
          _SimpleMediaList(
            items: mediaContentsState.value,
          ),
        if (mediaContentsState is Loading) const LoadingView(),
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
    return items.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return MediaItemAdd(item: items[index], onFolderTap: () {});
            },
          )
        : const EmptyView(
            type: BlankMessageType.ADD_CONTENT,
            onPressed: null,
          );
  }
}
