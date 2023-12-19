import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/SimpleMediaContentModel.dart';
import 'package:menuboss/presentation/features/media_content/provider/MediaContentsProvider.dart';
import 'package:menuboss_common/components/bottom_sheet/BottomSheetFilterSelector.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/view_state/EmptyView.dart';
import 'package:menuboss_common/components/view_state/FailView.dart';
import 'package:menuboss_common/components/view_state/LoadingView.dart';
import 'package:menuboss_common/components/view_state/LoadingView.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/UiState.dart';

import 'MediaItemAdd.dart';

class MediaTab extends HookConsumerWidget {
  final Function(String) onFolderTap;

  const MediaTab({
    super.key,
    required this.onFolderTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    final mediaContentsState = ref.watch(mediaContentsProvider);
    final mediaContentsManager = ref.read(mediaContentsProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        mediaContentsManager.updateFilterKeys(FilterInfo.getFilterKey(context));
        mediaContentsManager.requestGetMedias(); // 미디어 목록 호출
      });
      return () {
        Future(() {
          mediaContentsManager.initPageInfo();
          mediaContentsManager.init();
        });
      };
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
          FailView(
            onPressed: () => mediaContentsManager.requestGetMedias(),
          )
        else if (mediaContentsState is Success<List<SimpleMediaContentModel>>)
          _SimpleMediaList(
            items: mediaContentsState.value,
            onFolderTap: (folderId) {
              onFolderTap.call(folderId);
            },
          ),
        if (mediaContentsState is Loading) const LoadingView(),
      ],
    );
  }
}

class _SimpleMediaList extends HookConsumerWidget {
  final Function(String) onFolderTap;
  final List<SimpleMediaContentModel> items;

  const _SimpleMediaList({
    super.key,
    required this.items,
    required this.onFolderTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaContentsManager = ref.read(mediaContentsProvider.notifier);
    final scrollController = useScrollController(keepScrollOffset: true);

    useEffect(() {
      scrollController.addListener(() {
        if (scrollController.position.maxScrollExtent * 0.7 <= scrollController.position.pixels) {
          mediaContentsManager.requestGetMedias();
        }
      });
      return null;
    }, []);

    return items.isNotEmpty
        ? RefreshIndicator(
            onRefresh: () async {
              mediaContentsManager.initPageInfo();
              mediaContentsManager.requestGetMedias();
            },
            color: getColorScheme(context).colorPrimary500,
            backgroundColor: getColorScheme(context).white,
            child: ListView.builder(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return MediaItemAdd(item: items[index], onFolderTap: () => onFolderTap.call(items[index].id ?? ""));
              },
            ),
          )
        : const EmptyView(
            type: BlankMessageType.ADD_CONTENT,
            onPressed: null,
          );
  }
}
