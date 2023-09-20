import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistModel.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss/presentation/components/appbar/TopBarNoneTitleIcon.dart';
import 'package:menuboss/presentation/components/divider/DividerVertical.dart';
import 'package:menuboss/presentation/components/loading/LoadingView.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/features/media_content/provider/MediaContentsCartProvider.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/Common.dart';

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

    final playListRegisterState = ref.watch(PlayListRegisterProvider);
    final playListUpdateState = ref.watch(PlayListUpdateProvider);
    final playListRegisterProvider = ref.read(PlayListRegisterProvider.notifier);
    final playListUpdateProvider = ref.read(PlayListUpdateProvider.notifier);
    final mediaCartProvider = ref.read(MediaContentsCartProvider.notifier);
    final saveProvider = ref.read(PlaylistSaveInfoProvider.notifier);

    void initState() {
      mediaCartProvider.init();
      saveProvider.init();
      playListRegisterProvider.init();
      playListUpdateProvider.init();
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        initState();
      });
      return null;
    }, []);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (isEditMode.value) {
          debugPrint("item: ${item.toString()}");

          saveProvider.changeName(item?.name ?? "");
          saveProvider.changeDirection(
            item?.property?.direction?.code.toLowerCase() == "horizontal"
                ? PlaylistSettingType.Horizontal
                : PlaylistSettingType.Vertical,
          );

          saveProvider.changeFill(
            item?.property?.fill?.code.toLowerCase() == "fill" ? PlaylistSettingType.Fill : PlaylistSettingType.Fit,
          );

          mediaCartProvider.addItems(
            item?.contents?.map((e) => e.toMapperMediaContentModel()).toList() ?? [],
          );
        }
      });
      return null;
    }, [isEditMode.value]);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          playListRegisterState.when(
            success: (event) {
              initState();
              Navigator.of(context).pop(true);
            },
            failure: (event) => ToastUtil.errorToast(event.errorMessage),
          );
          playListUpdateState.when(
            success: (event) {
              initState();
              Navigator.of(context).pop(true);
            },
            failure: (event) => ToastUtil.errorToast(event.errorMessage),
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
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          PlaylistInputName(
                            initTitle: item?.name ?? "",
                          ),
                          PlaylistSettings(
                            direction: item?.property?.direction?.code.toLowerCase() == "horizontal"
                                ? PlaylistSettingType.Horizontal
                                : PlaylistSettingType.Vertical,
                            scale: item?.property?.fill?.code.toLowerCase() == "fill"
                                ? PlaylistSettingType.Fill
                                : PlaylistSettingType.Fit,
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
              if (playListRegisterState is Loading || playListUpdateState is Loading) const LoadingView(),
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
