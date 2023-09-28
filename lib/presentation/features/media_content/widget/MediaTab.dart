import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/SimpleMediaContentModel.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/view_state/FailView.dart';
import 'package:menuboss/presentation/components/view_state/LoadingView.dart';
import 'package:menuboss/presentation/features/media_content/provider/MediaContentsProvider.dart';
import 'package:menuboss/presentation/model/UiState.dart';

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

    final mediaContents = useState<List<SimpleMediaContentModel>?>(null);
    final mediaContentsState = ref.watch(MediaContentsProvider);
    final mediaContentsProvider = ref.read(MediaContentsProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        mediaContentsProvider.requestGetMedias(); // 미디어 목록 호출
      });
      return null;
    },[]);

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
        if (mediaContentsState is Failure)
          FailView(onPressed: () => mediaContentsProvider.requestGetMedias())
        else if (mediaContents.value != null)
          _SimpleMediaList(
            items: mediaContents.value!,
            onFolderTap: (folderId) {
              onFolderTap.call(folderId);
            },
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
    final mediaContentsProvider = ref.read(MediaContentsProvider.notifier);
    final scrollController = useScrollController(keepScrollOffset: true);

    useEffect(() {
      scrollController.addListener(() {
        if (scrollController.position.maxScrollExtent * 0.7 <= scrollController.position.pixels) {
          mediaContentsProvider.requestGetMedias();
        }
      });
      return null;
    }, []);

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      itemCount: items.length,
      itemBuilder: (context, index) {
        debugPrint("index: ${items[index].id} ${items[index].property}}");
        return MediaItemAdd(item: items[index], onFolderTap: () => onFolderTap.call(items[index].id ?? ""));
      },
    );
  }
}
