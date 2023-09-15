import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/components/button/NeutralLineButton.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/features/create/playlist/provider/PlaylistSettingInfoProvider/PlaylistSaveInfoProvider.dart';
import 'package:menuboss/presentation/features/media_content/provider/MediaContentsCartProvider.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class PlaylistBottomContent extends HookConsumerWidget {
  const PlaylistBottomContent({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaCart = ref.watch(MediaContentsCartProvider);
    final playlistSaveInfo = ref.watch(PlaylistSaveInfoProvider);

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
                        onPressed: () {},
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
                        onPressed: () {},
                        content: getAppLocalizations(context).common_save,
                        isActivated: playlistSaveInfo!.isCreateAvailable(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : SizedBox();
  }
}
