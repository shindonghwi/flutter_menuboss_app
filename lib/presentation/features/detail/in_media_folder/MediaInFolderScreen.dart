import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleIcon.dart';
import 'package:menuboss/presentation/components/button/FloatingButton.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/components/utils/ClickableScale.dart';
import 'package:menuboss/presentation/components/view_state/EmptyView.dart';
import 'package:menuboss/presentation/components/view_state/FailView.dart';
import 'package:menuboss/presentation/components/view_state/LoadingView.dart';
import 'package:menuboss/presentation/features/main/media/widget/MediaItem.dart';
import 'package:menuboss/presentation/features/media_info/provider/MediaNameChangeProvider.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/utils/dto/Pair.dart';

class MediaInFolderScreen extends HookConsumerWidget {
  final ResponseMediaModel? item;

  const MediaInFolderScreen({
    super.key,
    this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final mediaFolderInfoState = ref.watch(GetMediaFolderInfoProvider);
    // final mediaFolderInfoProvider = ref.read(GetMediaFolderInfoProvider.notifier);
    // final mediaList = useState<List<ResponseMediaModel>?>(null);

    return Container();

    // useEffect(() {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     mediaFolderInfoProvider.requestMediaInfo(item?.mediaId ?? "");
    //   });
    //   return null;
    // }, []);
    //
    // useEffect(() {
    //   void handleUiStateChange() async {
    //     await Future(() {
    //       mediaFolderInfoState.when(
    //         success: (event) {
    //           mediaList.value = event.value;
    //           mediaFolderInfoProvider.init();
    //         },
    //         failure: (event) => Toast.showError(context, event.errorMessage),
    //       );
    //     });
    //   }
    //
    //   handleUiStateChange();
    //   return null;
    // }, [mediaFolderInfoState]);
    //
    // return BaseScaffold(
    //   appBar: TopBarIconTitleIcon(
    //     leadingIsShow: true,
    //     content: item?.name ?? "",
    //     suffixIcons: [
    //       Pair("assets/imgs/icon_check_round.svg", () {}),
    //     ],
    //   ),
    //   body: Stack(
    //     children: [
    //       if (mediaFolderInfoState is Failure)
    //         FailView(onPressed: () => mediaFolderInfoProvider.requestMediaInfo(item?.mediaId ?? ""))
    //       else if (mediaList.value != null)
    //         _MediaContentList(
    //           items: mediaList.value!,
    //           onMediaUpload: () {},
    //         )
    //       else if (mediaFolderInfoState is Success<List<ResponseMediaModel>>)
    //         _MediaContentList(
    //           items: mediaFolderInfoState.value,
    //           onMediaUpload: () {},
    //         ),
    //       if (mediaFolderInfoState is Loading) const LoadingView(),
    //     ],
    //   ),
    // );
  }
}

class _MediaContentList extends HookConsumerWidget {
  final List<ResponseMediaModel> items;
  final VoidCallback onMediaUpload;

  const _MediaContentList({
    super.key,
    required this.items,
    required this.onMediaUpload,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return items.isNotEmpty
        ? Stack(
            children: [
              ListView.builder(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ClickableScale(
                    onPressed: () async {
                      try {
                        final newName = await Navigator.push(
                          context,
                          nextSlideHorizontalScreen(
                            RoutingScreen.MediaInfo.route,
                            parameter: item,
                          ),
                        );

                        // if (!CollectionUtil.isNullEmptyFromString(newName)) {
                        //   mediaProvider.renameItem(item.mediaId, newName);
                        // }
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                    },
                    child: MediaItem(
                      item: item,
                      onRemove: () {
                        // mediaProvider.removeItem([item.mediaId]);
                      },
                      onRename: (newName) {
                        // mediaProvider.renameItem(item.mediaId, newName);
                      },
                    ),
                  );
                },
              ),
              Container(
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.only(bottom: 32, right: 24),
                child: FloatingPlusButton(
                  onPressed: () => onMediaUpload.call(),
                ),
              ),
            ],
          )
        : EmptyView(
            type: BlankMessageType.UPLOAD_FILE,
            onPressed: () => onMediaUpload.call(),
          );
  }
}
