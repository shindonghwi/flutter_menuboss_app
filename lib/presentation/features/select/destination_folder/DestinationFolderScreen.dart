import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/presentation/components/appbar/TopBarNoneTitleIcon.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/components/view_state/FailView.dart';
import 'package:menuboss/presentation/components/view_state/LoadingView.dart';
import 'package:menuboss/presentation/features/main/media/provider/MediaListProvider.dart';
import 'package:menuboss/presentation/features/select/destination_folder/widget/DestinationFolderBottomContent.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import 'provider/DestinationFolderListProvider.dart';
import 'provider/FileMoveProvider.dart';

class DestinationFolderScreen extends HookConsumerWidget {
  final List<String> mediaIds;

  const DestinationFolderScreen({
    super.key,
    this.mediaIds = const [],
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaListManager = ref.read(mediaListProvider.notifier);
    final fileMoveState = ref.watch(FileMoveProvider);
    final fileMoveProvider = ref.read(FileMoveProvider.notifier);
    final destinationFolderState = ref.watch(DestinationFolderListProvider);
    final destinationFolderProvider = ref.read(DestinationFolderListProvider.notifier);
    final ValueNotifier<String?> isSelectFolderId = useState(null);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        destinationFolderProvider.requestGetFolders();
      });
      return null;
    }, []);

    useEffect(() {
      void handleUiStateChange() {
        fileMoveState.when(
          success: (event) async {
            mediaListManager.initPageInfo();
            mediaListManager.requestGetMedias();
            Navigator.of(context).pop();
          },
          failure: (event) => Toast.showError(context, event.errorMessage),
        );
        destinationFolderState.when(
          failure: (event) => Toast.showError(context, event.errorMessage),
        );
      }

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await fileMoveProvider.init();
        handleUiStateChange();
      });
      return null;
    }, [fileMoveState, destinationFolderState]);

    return BaseScaffold(
      appBar: TopBarNoneTitleIcon(
        content: getAppLocalizations(context).destination_folder_title,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            if (destinationFolderState is Failure)
              FailView(onPressed: () => destinationFolderProvider.requestGetFolders())
            else if (destinationFolderState is Success<List<ResponseMediaModel?>>)
              ListView.builder(
                padding: const EdgeInsets.only(bottom: 100),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                controller: useScrollController(keepScrollOffset: true),
                itemCount: destinationFolderState.value.length,
                itemBuilder: (context, index) {
                  final inRoot = index == 0;
                  final item = destinationFolderState.value[index];
                  return Container(
                    color: isSelectFolderId.value == item?.mediaId
                        ? getColorScheme(context).colorGray50
                        : getColorScheme(context).white,
                    child: Clickable(
                      key: ValueKey(item?.mediaId ?? index),
                      onPressed: () async {
                        isSelectFolderId.value = item?.mediaId;
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        child: inRoot
                            ? Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/imgs/icon_chevron_down.svg",
                                    width: 24,
                                    height: 24,
                                    colorFilter: ColorFilter.mode(
                                      getColorScheme(context).colorGray500,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 12),
                                    child: _FolderItem(folderName: item?.name ?? ""),
                                  ),
                                ],
                              )
                            : Container(
                                margin: const EdgeInsets.only(left: 56),
                                child: _FolderItem(folderName: item?.name ?? ""),
                              ),
                      ),
                    ),
                  );
                },
              ),
            if (destinationFolderState is Loading || fileMoveState is Loading) const LoadingView(),
          ],
        ),
      ),
      bottomNavigationBar: DestinationFolderBottomContent(
        onNewFolderClick: () async {
          ResponseMediaModel? newFolder = await destinationFolderProvider.createFolder();
          if (newFolder != null) {
            mediaListManager.updateCurrentItems(
              [newFolder, ...mediaListManager.currentItems],
              isUiUpdate: true,
            );
          }
        },
        onMoveHereClick: () {
          fileMoveProvider.requestFileMove(mediaIds, isSelectFolderId.value);
        },
      ),
    );
  }
}

class _FolderItem extends StatelessWidget {
  final String folderName;

  const _FolderItem({
    super.key,
    required this.folderName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/imgs/icon_folder.svg",
          width: 24,
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(
            folderName,
            style: getTextTheme(context).b2sb.copyWith(
                  color: getColorScheme(context).colorGray900,
                ),
          ),
        )
      ],
    );
  }
}
