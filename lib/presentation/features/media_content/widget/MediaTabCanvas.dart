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
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import 'MediaItemAdd.dart';

class MediaTabCanvas extends HookConsumerWidget {
  const MediaTabCanvas({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    final mediaContentsState = ref.watch(mediaContentsCanvasProvider);
    final mediaContentsManager = ref.read(mediaContentsCanvasProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        mediaContentsManager.requestGetCanvases();
      });
      return null;
    }, []);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          mediaContentsState.when(
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
          FailView(onPressed: () => mediaContentsManager.requestGetCanvases())
        else if (mediaContentsState is Success<List<SimpleMediaContentModel>>)
          _SimpleMediaList(items: mediaContentsState.value),
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
    final mediaContentsManager = ref.read(mediaContentsCanvasProvider.notifier);
    return items.isNotEmpty
        ? RefreshIndicator(
            onRefresh: () async {
              mediaContentsManager.requestGetCanvases(delayed: 300);
            },
            color: getColorScheme(context).colorPrimary500,
            backgroundColor: getColorScheme(context).white,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return MediaItemAdd(item: items[index], onFolderTap: () {});
              },
            ),
          )
        : const EmptyView(
            type: BlankMessageType.ADD_CANVAS,
            onPressed: null,
          );
  }
}
