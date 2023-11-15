import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistModel.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss/presentation/components/appbar/TopBarNoneTitleIcon.dart';
import 'package:menuboss/presentation/components/divider/DividerVertical.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/features/create/playlist/provider/CreatePreviewItemProcessProvider.dart';
import 'package:menuboss/presentation/features/main/playlists/provider/PlaylistProvider.dart';
import 'package:menuboss/presentation/features/media_content/provider/MediaContentsCartProvider.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import '../../../components/view_state/LoadingView.dart';
import 'provider/PlayListRegisterProvider.dart';
import 'provider/PlayListUpdateProvider.dart';
import 'provider/PlaylistSaveInfoProvider.dart';
import 'widget/PlaylistBottomContent.dart';
import 'widget/PlaylistContents.dart';
import 'widget/PlaylistInputName.dart';
import 'widget/PlaylistSettings.dart';
import 'widget/PlaylistTotalDuration.dart';

class CreatePlaylistScreen extends HookConsumerWidget {
  final ResponsePlaylistModel? item;

  const CreatePlaylistScreen({
    super.key,
    this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = useState(item != null);

    final playlistsManager = ref.read(playListProvider.notifier);

    final playListRegisterState = ref.watch(playListRegisterProvider);
    final playListRegisterManager = ref.read(playListRegisterProvider.notifier);

    final playListUpdateState = ref.watch(playListUpdateProvider);
    final playListUpdateManager = ref.read(playListUpdateProvider.notifier);

    final createPreviewProcessState = ref.watch(createPreviewItemProcessProvider);
    final createPreviewProcessManager = ref.read(createPreviewItemProcessProvider.notifier);

    final mediaCartManager = ref.read(mediaContentsCartProvider.notifier);
    final saveManager = ref.read(playlistSaveInfoProvider.notifier);

    useEffect(() {
      return () {
        Future(() {
          playListRegisterManager.init();
          playListUpdateManager.init();

          mediaCartManager.init();
          saveManager.init();

          createPreviewProcessManager.init();
        });
      };
    }, []);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (isEditMode.value) {
          saveManager.changeName(item?.name ?? "");
          saveManager.changeDirection(getPlaylistDirectionTypeFromString(item?.property?.direction?.code));
          saveManager.changeFill(getPlaylistScaleTypeFromString(item?.property?.fill?.code));
          mediaCartManager.addItems(item?.contents?.map((e) => e.toMapperMediaContentModel()).toList() ?? []);
        }
      });
      return null;
    }, [isEditMode.value]);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          playListRegisterState.when(
            success: (event) {
              Toast.showSuccess(context, getAppLocalizations(context).message_register_playlist_success);
              playlistsManager.requestGetPlaylists();
              Navigator.of(context).pop();
            },
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
          playListUpdateState.when(
            success: (event) {
              Toast.showSuccess(context, getAppLocalizations(context).message_update_playlist_success);
              playlistsManager.requestGetPlaylists();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [playListRegisterState, playListUpdateState]);

    return BaseScaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: isEditMode.value
            ? TopBarIconTitleNone(content: getAppLocalizations(context).edit_playlist_title)
            : TopBarNoneTitleIcon(content: getAppLocalizations(context).create_playlist_title),
      ),
      body: Container(
        color: getColorScheme(context).white,
        child: SafeArea(
          child: Stack(
            children: [
              NestedScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          PlaylistInputName(
                            initTitle: item?.name ?? "",
                          ),
                          PlaylistSettings(
                            direction: getPlaylistDirectionTypeFromString(item?.property?.direction?.code),
                            scale: getPlaylistDirectionTypeFromString(item?.property?.fill?.code),
                          ),
                        ],
                      ),
                    ),
                  ];
                },
                body: const Column(
                  children: [
                    DividerVertical(marginVertical: 0),
                    PlaylistTotalDuration(),
                    PlaylistContents(),
                  ],
                ),
              ),
              if (playListRegisterState is Loading || playListUpdateState is Loading || createPreviewProcessState is Loading) const LoadingView(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: PlaylistBottomContent(
        playlistId: item?.playlistId,
        isEditMode: isEditMode.value,
      ),
    );
  }
}
