import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/SimpleMediaContentModel.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/components/view_state/EmptyView.dart';
import 'package:menuboss/presentation/components/view_state/FailView.dart';
import 'package:menuboss/presentation/components/view_state/LoadingView.dart';
import 'package:menuboss/presentation/features/media_content/provider/MediaContentsInFolderProvider.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import 'MediaItemAdd.dart';

class MediaTabFolder extends HookConsumerWidget {
  final String folderId;
  final PageController pageController;
  final VoidCallback onPressed;

  const MediaTabFolder({
    super.key,
    required this.pageController,
    required this.onPressed,
    required this.folderId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaContentsState = ref.watch(mediaContentsInFolderProvider);
    final mediaContentsManager = ref.read(mediaContentsInFolderProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        mediaContentsManager.requestGetMedias(folderId);
      });
      return () {
        Future(() {
          mediaContentsManager.initPageInfo();
          mediaContentsManager.init();
        });
      };
    }, [folderId]);

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

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Clickable(
            onPressed: () => onPressed.call(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    "assets/imgs/icon_back.svg",
                    width: 16,
                    height: 16,
                    colorFilter: ColorFilter.mode(
                      getColorScheme(context).colorGray900,
                      BlendMode.srcIn,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Back",
                      style: getTextTheme(context).b3sb.copyWith(
                            color: getColorScheme(context).colorGray900,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                if (mediaContentsState is Failure)
                  FailView(onPressed: () => mediaContentsManager.requestGetMedias(folderId))
                else if (mediaContentsState is Success<List<SimpleMediaContentModel>>)
                  _SimpleMediaList(
                    folderId: folderId,
                    items: mediaContentsState.value,
                  ),
                if (mediaContentsState is Loading) const LoadingView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SimpleMediaList extends HookConsumerWidget {
  final String folderId;
  final List<SimpleMediaContentModel> items;

  const _SimpleMediaList({
    super.key,
    required this.folderId,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaContentsManager = ref.read(mediaContentsInFolderProvider.notifier);
    final scrollController = useScrollController(keepScrollOffset: true);

    useEffect(() {
      scrollController.addListener(() {
        if (scrollController.position.maxScrollExtent * 0.7 <= scrollController.position.pixels) {
          mediaContentsManager.requestGetMedias(folderId);
        }
      });
      return null;
    }, []);

    return items.isNotEmpty
        ? RefreshIndicator(
            onRefresh: () async {
              mediaContentsManager.initPageInfo();
              mediaContentsManager.requestGetMedias(folderId, delay: 300);
            },
            color: getColorScheme(context).colorPrimary500,
            backgroundColor: getColorScheme(context).white,
            child: ListView.builder(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return MediaItemAdd(item: items[index], onFolderTap: () {});
              },
            ),
          )
        : const EmptyView(
            type: BlankMessageType.ADD_CONTENT,
            onPressed: null,
          );
    ;
  }
}
