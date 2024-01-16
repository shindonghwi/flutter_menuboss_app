import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/presentation/features/main/media/provider/MediaListProvider.dart';
import 'package:menuboss/presentation/features/select/destination_folder/widget/DestinationFolderBottomContent.dart';
import 'package:menuboss_common/components/appbar/TopBarNoneTitleIcon.dart';
import 'package:menuboss_common/components/bottom_sheet/BottomSheetFilterSelector.dart';
import 'package:menuboss_common/components/checkbox/radio/BasicBorderRadioButton.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/components/utils/Clickable.dart';
import 'package:menuboss_common/components/view_state/FailView.dart';
import 'package:menuboss_common/components/view_state/LoadingView.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/CollectionUtil.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/UiState.dart';

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
    final ValueNotifier<int> isSelectFolderIndex = useState(0);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        destinationFolderProvider.requestGetFolders(
          rootFolderName: getString(context).destinationFolderRoot,
          filterKeys: FilterInfo.getFilterKey(context),
        );
      });
      return null;
    }, []);

    useEffect(() {
      void handleUiStateChange() {
        fileMoveState.when(
          success: (event) async {
            Toast.showSuccess(
                context, getString(context).messageMoveMediaSuccess(event.value.toString()));
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
        content: getString(context).destinationFolderTitle,
        onBack: () => popPageWrapper(context: context),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            if (destinationFolderState is Failure)
              FailView(
                onPressed: () => destinationFolderProvider.requestGetFolders(
                  rootFolderName: getString(context).destinationFolderRoot,
                  filterKeys: FilterInfo.getFilterKey(context),
                ),
              )
            else if (destinationFolderState is Success<List<ResponseMediaModel?>>)
              ListView.builder(
                padding: const EdgeInsets.only(bottom: 100),
                physics: const AlwaysScrollableScrollPhysics(),
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
                        isSelectFolderIndex.value = index;
                        if (CollectionUtil.isNullEmptyFromString(item?.mediaId)) {
                          isSelectFolderId.value = null;
                        } else {
                          isSelectFolderId.value = item?.mediaId;
                        }
                        debugPrint(
                            "isSelectFolderId: ${isSelectFolderId.value}  ${isSelectFolderId.value == null}");
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        child: _FolderItem(
                          inRoot: inRoot,
                          folderName: item?.name ?? "",
                          isSelected: isSelectFolderIndex.value == index,
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
          fileMoveProvider.requestFileMove(
            mediaIds,
            isSelectFolderId.value,
            mediaListManager.getFolderName(
              getString(context).destinationFolderRoot,
              isSelectFolderId.value,
            ),
          );
        },
      ),
    );
  }
}

class _FolderItem extends StatelessWidget {
  final bool inRoot;
  final String folderName;
  final bool isSelected;

  const _FolderItem({
    super.key,
    required this.inRoot,
    required this.folderName,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              if (inRoot)
                LoadSvg(
                  path: "assets/imgs/icon_chevron_down.svg",
                  width: 24,
                  height: 24,
                  color: getColorScheme(context).colorGray500,
                ),
              Container(
                margin: EdgeInsets.only(left: inRoot ? 12 : 56),
                child: LoadSvg(
                  path: "assets/imgs/icon_folder.svg",
                  width: 24,
                  height: 24,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    folderName,
                    style: getTextTheme(context).b2m.copyWith(
                          color: getColorScheme(context).colorGray900,
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
        if (isSelected)
          SizedBox(
            width: 20,
            height: 20,
            child: BasicBorderRadioButton(
              isChecked: true,
              onChange: (value) {},
            ),
          ),
      ],
    );
  }
}
