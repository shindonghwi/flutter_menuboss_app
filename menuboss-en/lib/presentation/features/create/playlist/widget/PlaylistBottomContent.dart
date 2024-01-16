import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/presentation/features/create/playlist/provider/PlayListRegisterProvider.dart';
import 'package:menuboss/presentation/features/create/playlist/provider/PlayListUpdateProvider.dart';
import 'package:menuboss/presentation/features/create/playlist/provider/PlaylistSaveInfoProvider.dart';
import 'package:menuboss/presentation/features/media_content/provider/MediaContentsCartProvider.dart';
import 'package:menuboss_common/components/button/PrimaryFilledButton.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/utils/Common.dart';

class PlaylistBottomContent extends HookConsumerWidget {
  final int? playlistId;
  final bool isEditMode;

  const PlaylistBottomContent({
    super.key,
    required this.playlistId,
    required this.isEditMode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaCart = ref.watch(mediaContentsCartProvider);
    final playListUpdateManager = ref.read(playListUpdateProvider.notifier);
    final playListRegisterManager = ref.read(playListRegisterProvider.notifier);
    final saveManager = ref.watch(playlistSaveInfoProvider);

    return mediaCart.isNotEmpty
        ? Container(
            color: getColorScheme(context).white,
            child: SafeArea(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: PrimaryFilledButton.largeRound8(
                  onPressed: () {
                    if (isEditMode) {
                      playListUpdateManager.updatePlaylist(playlistId ?? -1, saveManager);
                    } else {
                      playListRegisterManager.registerPlaylist(saveManager);
                    }
                  },
                  content: getString(context).commonSave,
                  isActivated: saveManager.isCreateAvailable(),
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
