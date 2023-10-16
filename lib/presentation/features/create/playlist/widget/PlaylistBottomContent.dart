import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/button/NeutralLineButton.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/features/create/playlist/provider/PlayListRegisterProvider.dart';
import 'package:menuboss/presentation/features/create/playlist/provider/PlayListUpdateProvider.dart';
import 'package:menuboss/presentation/features/media_content/provider/MediaContentsCartProvider.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import '../provider/PlaylistSaveInfoProvider.dart';

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
    final playlistSaveInfo = ref.watch(playlistSaveInfoProvider);

    return mediaCart.isNotEmpty
        ? Container(
            color: getColorScheme(context).white,
            child: SafeArea(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: NeutralLineButton.largeRound8(
                        onPressed: () {
                          Navigator.push(
                            context,
                            nextSlideVerticalScreen(
                              RoutingScreen.PreviewPlaylist.route,
                            ),
                          );
                        },
                        content: getAppLocalizations(context).common_preview,
                        isActivated: true,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: PrimaryFilledButton.largeRound8(
                        onPressed: () {
                          if (isEditMode) {
                            playListUpdateManager.updatePlaylist(playlistId ?? -1, playlistSaveInfo);
                          } else {
                            playListRegisterManager.registerPlaylist(playlistSaveInfo);
                          }
                        },
                        content: getAppLocalizations(context).common_save,
                        isActivated: playlistSaveInfo.isCreateAvailable(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
