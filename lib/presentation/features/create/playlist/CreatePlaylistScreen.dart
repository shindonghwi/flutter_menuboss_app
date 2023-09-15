import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/components/appbar/TopBarNoneTitleIcon.dart';
import 'package:menuboss/presentation/components/divider/DividerVertical.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/features/media_content/provider/MediaContentsCartProvider.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import 'provider/PlaylistSettingInfoProvider/PlaylistSaveInfoProvider.dart';
import 'widget/PlaylistBottomContent.dart';
import 'widget/PlaylistContents.dart';
import 'widget/PlaylistInputName.dart';
import 'widget/PlaylistSettings.dart';
import 'widget/PlaylistTotalDuration.dart';

class CreatePlaylistScreen extends HookConsumerWidget {
  const CreatePlaylistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final mediaCartProvider = ref.read(MediaContentsCartProvider.notifier);
    final saveProvider = ref.read(PlaylistSaveInfoProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        mediaCartProvider.init();
        saveProvider.init();
      });
      return null;
    },[]);

    return BaseScaffold(
      appBar: TopBarNoneTitleIcon(
        content: getAppLocalizations(context).create_playlist_title,
      ),
      body: Container(
        color: getColorScheme(context).white,
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                const SliverToBoxAdapter(
                  child: Column(
                    children: [
                      PlaylistInputName(),
                      PlaylistSettings(),
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
        ),
      ),
      bottomNavigationBar: const PlaylistBottomContent(),
    );
  }
}
