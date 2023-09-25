import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
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
    final selectMediaState = ref.watch(SelectMediaInFolderListProvider);
    final selectMediaListProvider = ref.read(SelectMediaInFolderListProvider.notifier);
    final mediaProvider = ref.read(MediaListProvider.notifier);
    final checkListState = ref.watch(SelectMediaCheckListProvider);
    final mediaList = useState<List<ResponseMediaModel>?>(null);
    //
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        selectMediaListProvider.initPageInfo();
        selectMediaListProvider.requestGetMedias(mediaId: item!.mediaId);
      });
      return null;
    }, []);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          selectMediaState.when(
            success: (event) {
              mediaList.value = event.value;
            },
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
            FailView(onPressed: () => selectMediaListProvider.requestGetMedias(mediaId: item!.mediaId))
          else if (mediaList.value != null)
            _MediaContentList(
              folderId: item!.mediaId,
              items: mediaList.value!,
            )
          else if (selectMediaState is Success<List<ResponseMediaModel>>)
            _MediaContentList(
              folderId: item!.mediaId,
              items: selectMediaState.value,
            ),
          if (selectMediaState is Loading) const LoadingView(),
        ],
      ),
      bottomNavigationBar: SelectMediaBottomContent(
        onMovedClick: () {},
        onDeleteClick: () {
          mediaProvider.removeItem(checkListState);
          int count = mediaList.value!.where((element) => checkListState.contains(element.mediaId)).length;
          for (int i = 0; i < count; i++) {
            mediaProvider.changeFolderCount(item!.mediaId, isIncrement: false);
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
    final checkListProvider = ref.read(SelectMediaCheckListProvider.notifier);
    final mediaProvider = ref.read(SelectMediaInFolderListProvider.notifier);
    final scrollController = useScrollController(keepScrollOffset: true);

    useEffect(() {
      scrollController.addListener(() {
        if (scrollController.position.maxScrollExtent * 0.7 <= scrollController.position.pixels) {
          mediaProvider.requestGetMedias(mediaId: folderId);
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
                      checkListProvider.onChanged(item.mediaId);
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
