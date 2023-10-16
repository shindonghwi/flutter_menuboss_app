import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/components/utils/ClickableScale.dart';
import 'package:menuboss/presentation/components/view_state/EmptyView.dart';
import 'package:menuboss/presentation/components/view_state/FailView.dart';
import 'package:menuboss/presentation/components/view_state/LoadingView.dart';
import 'package:menuboss/presentation/features/main/media/provider/MediaListProvider.dart';
import 'package:menuboss/presentation/features/select/media_file/provider/SelectMediaCheckListProvider.dart';
import 'package:menuboss/presentation/features/select/media_file/widget/SelectMediaBottomContent.dart';
import 'package:menuboss/presentation/features/select/media_file/widget/SelectMediaItem.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import 'provider/SelectMediaInFolderListProvider.dart';

class SelectMediaInFolderScreen extends HookConsumerWidget {
  final ResponseMediaModel? item;

  const SelectMediaInFolderScreen({
    super.key,
    this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectMediaState = ref.watch(selectMediaInFolderListProvider);
    final selectMediaListManager = ref.read(selectMediaInFolderListProvider.notifier);
    final mediaListManager = ref.read(mediaListProvider.notifier);
    final checkListState = ref.watch(selectMediaCheckListProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        selectMediaListManager.requestGetMedias(mediaId: item!.mediaId);
      });
      return (){
        Future(() {
          selectMediaListManager.initPageInfo();
        });
      };
    }, []);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          selectMediaState.when(
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [selectMediaState]);

    return BaseScaffold(
      appBar: TopBarIconTitleNone(
        content: getAppLocalizations(context).select_media_file_title(checkListState.length),
      ),
      body: Stack(
        children: [
          if (selectMediaState is Failure)
            FailView(onPressed: () => selectMediaListManager.requestGetMedias(mediaId: item!.mediaId))
          else if (selectMediaState is Success<List<ResponseMediaModel>>)
            _MediaContentList(
              folderId: item!.mediaId,
              items: selectMediaState.value,
            ),
          if (selectMediaState is Loading) const LoadingView(),
        ],
      ),
      bottomNavigationBar: SelectMediaBottomContent(
        onMovedClick: () {
          Navigator.of(context).pop();
          Navigator.pushReplacement(
            context,
            nextSlideVerticalScreen(
              RoutingScreen.SelectDestinationFolder.route,
              parameter: checkListState,
            ),
          );
        },
        onDeleteClick: () async{
          final isSuccess = await mediaListManager.removeItem(checkListState, folderId: item!.mediaId);
          if (isSuccess) {
            mediaListManager.initPageInfo();
            mediaListManager.requestGetMedias();
          }
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

class _MediaContentList extends HookConsumerWidget {
  final String folderId;
  final List<ResponseMediaModel> items;

  const _MediaContentList({
    super.key,
    required this.items,
    required this.folderId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkListManager = ref.read(selectMediaCheckListProvider.notifier);
    final mediaListManager = ref.read(selectMediaInFolderListProvider.notifier);
    final scrollController = useScrollController(keepScrollOffset: true);

    useEffect(() {
      scrollController.addListener(() {
        if (scrollController.position.maxScrollExtent * 0.7 <= scrollController.position.pixels) {
          mediaListManager.requestGetMedias(mediaId: folderId);
        }
      });
      return null;
    }, []);


    return items.isNotEmpty
        ? Stack(
            children: [
              ListView.builder(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                controller: scrollController,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ClickableScale(
                    onPressed: () async {
                      checkListManager.onChanged(item.mediaId);
                    },
                    child: SelectMediaItem(
                      item: item,
                    ),
                  );
                },
              ),
            ],
          )
        : const EmptyView(
            type: BlankMessageType.UPLOAD_FILE,
            onPressed: null,
          );
  }
}
