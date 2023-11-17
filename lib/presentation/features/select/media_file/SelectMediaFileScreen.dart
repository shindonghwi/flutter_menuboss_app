import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/appbar/TopBarNoneTitleIcon.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/components/utils/ClickableScale.dart';
import 'package:menuboss/presentation/components/view_state/FailView.dart';
import 'package:menuboss/presentation/components/view_state/LoadingView.dart';
import 'package:menuboss/presentation/features/main/media/provider/MediaListProvider.dart';
import 'package:menuboss/presentation/features/select/media_file/provider/SelectMediaCheckListProvider.dart';
import 'package:menuboss/presentation/features/select/media_file/widget/SelectMediaBottomContent.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';
import 'package:menuboss/presentation/utils/Common.dart';

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
        content: getAppLocalizations(context).select_media_file_title(checkListState.length),
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
            Toast.showSuccess(context, getAppLocalizations(context).message_remove_media_success);
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
