import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/features/main/media/provider/MediaListProvider.dart';
import 'package:menuboss/presentation/features/select/media_file/provider/SelectMediaCheckListProvider.dart';
import 'package:menuboss/presentation/features/select/media_file/widget/SelectMediaBottomContent.dart';
import 'package:menuboss_common/components/appbar/TopBarNoneTitleIcon.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/components/utils/ClickableScale.dart';
import 'package:menuboss_common/components/view_state/FailView.dart';
import 'package:menuboss_common/components/view_state/LoadingView.dart';
import 'package:menuboss_common/ui/strings.dart';
import 'package:menuboss_common/utils/CollectionUtil.dart';
import 'package:menuboss_common/utils/UiState.dart';

import 'widget/SelectMediaItem.dart';

class SelectMediaFileScreen extends HookConsumerWidget {
  const SelectMediaFileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaState = ref.watch(mediaListProvider);
    final mediaManager = ref.read(mediaListProvider.notifier);
    final checkListState = ref.watch(selectMediaCheckListProvider);
    final checkListManager = ref.read(selectMediaCheckListProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!CollectionUtil.isNullorEmpty(mediaManager.currentItems)) {
          mediaManager.updateCurrentItems(mediaManager.currentItems, isUiUpdate: true);
        }
      });
      return () {
        Future(() {
          checkListManager.init();
          mediaManager.init();
        });
      };
    }, []);

    return BaseScaffold(
      appBar: TopBarNoneTitleIcon(
        content: Strings.of(context).select_media_file_title(checkListState.length),
        onBack: () => popPageWrapper(context: context),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            if (mediaState is Failure)
              FailView(onPressed: () => mediaManager.requestGetMedias())
            else if (mediaState is Success<List<ResponseMediaModel>>)
              _MediaList(
                items: mediaState.value,
              ),
            if (mediaState is Loading) const LoadingView(),
          ],
        ),
      ),
      bottomNavigationBar: SelectMediaBottomContent(
        onMovedClick: () {
          Navigator.pushReplacement(
            context,
            nextSlideVerticalScreen(
              RoutingScreen.SelectDestinationFolder.route,
              parameter: checkListState,
            ),
          );
        },
        onDeleteClick: () async {
          final isRemoved = await mediaManager.removeItem(checkListState);
          if (isRemoved) {
            Toast.showSuccess(context, Strings.of(context).messageRemoveMediaSuccess);
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}

class _MediaList extends HookConsumerWidget {
  final List<ResponseMediaModel> items;

  const _MediaList({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkListManager = ref.read(selectMediaCheckListProvider.notifier);
    final mediaManager = ref.read(mediaListProvider.notifier);
    final scrollController = useScrollController(keepScrollOffset: true);

    useEffect(() {
      scrollController.addListener(() {
        if (scrollController.position.maxScrollExtent * 0.7 <= scrollController.position.pixels) {
          mediaManager.requestGetMedias();
        }
      });
      return null;
    }, []);

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final isFolderType = item.type?.code.toLowerCase() == "folder";
        return ClickableScale(
          onPressed: () async {
            if (isFolderType) {
              Navigator.push(
                context,
                nextSlideHorizontalScreen(
                  RoutingScreen.SelectMediaInFolder.route,
                  parameter: item,
                ),
              );
            } else {
              checkListManager.onChanged(item.mediaId);
            }
          },
          child: SelectMediaItem(item: item),
        );
      },
    );
  }
}
