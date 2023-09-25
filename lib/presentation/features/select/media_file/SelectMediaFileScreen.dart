import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleNone.dart';
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
    final mediaState = ref.watch(MediaListProvider);
    final mediaProvider = ref.read(MediaListProvider.notifier);
    final mediaList = useState<List<ResponseMediaModel>?>(null);

    // final selectMediaState = ref.watch(SelectMediaFileProvider);
    // final selectMediaProvider = ref.read(SelectMediaFileProvider.notifier);
    // final selectMediaDeleteState = ref.watch(SelectMediaDeleteProvider);
    // final selectMediaDeleteProvider = ref.read(SelectMediaDeleteProvider.notifier);
    final checkListState = ref.watch(SelectMediaCheckListProvider);
    final checkListProvider = ref.read(SelectMediaCheckListProvider.notifier);
    // final mediaList = useState<List<ResponseMediaModel>?>(null);

    void initState() {
      // selectMediaProvider.init();
      // selectMediaListProvider.init();
      // selectMediaListProvider.initPageInfo();
      // selectMediaDeleteProvider.init();
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        checkListProvider.init();
        if (!CollectionUtil.isNullorEmpty(mediaProvider.currentItems)) {
          mediaProvider.updateCurrentItems(mediaProvider.currentItems, isUiUpdate: true);
        }
      });
      return null;
    }, []);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          // selectMediaListState.when(
          //   success: (event) {
          //     mediaList.value = event.value;
          //   },
          //   failure: (event) => Toast.showError(context, event.errorMessage),
          // );
          // selectMediaDeleteState.when(
          //   success: (event) {
          //     initState();
          //     Navigator.of(context).pop(true);
          //   },
          //   failure: (event) => Toast.showError(context, event.errorMessage),
          // );
        });
      }

      handleUiStateChange();
      return null;
    }, [mediaState]);

    return BaseScaffold(
      appBar: TopBarIconTitleNone(
        content: getAppLocalizations(context).select_media_file_title(checkListState.length),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            if (mediaState is Failure && mediaList.value == null)
              FailView(onPressed: () => mediaProvider.requestGetMedias())
            else if (mediaList.value != null)
              _MediaList(
                items: mediaList.value!,
              )
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
            ),
          );
        },
        onDeleteClick: () {
          mediaProvider.removeItem(checkListState);
          Navigator.of(context).pop();
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
    final checkListProvider = ref.read(SelectMediaCheckListProvider.notifier);
    final mediaProvider = ref.read(MediaListProvider.notifier);
    final scrollController = useScrollController(keepScrollOffset: true);

    useEffect(() {
      scrollController.addListener(() {
        if (scrollController.position.maxScrollExtent * 0.7 <= scrollController.position.pixels) {
          mediaProvider.requestGetMedias();
        }
      });
      return null;
    }, []);

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
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
              checkListProvider.onChanged(item.mediaId);
            }
          },
          child: SelectMediaItem(item: item),
        );
      },
    );
  }
}
