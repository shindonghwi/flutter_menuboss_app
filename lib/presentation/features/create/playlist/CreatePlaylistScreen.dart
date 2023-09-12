import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/presentation/components/appbar/TopBarNoneTitleIcon.dart';
import 'package:menuboss/presentation/components/button/NeutralLineButton.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/components/divider/DividerVertical.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import 'widget/PlaylistBottomContent.dart';
import 'widget/PlaylistContents.dart';
import 'widget/PlaylistInputName.dart';
import 'widget/PlaylistSettings.dart';
import 'widget/PlaylistTotalDuration.dart';

enum PlaylistSettingType {
  Horizontal,
  Vertical,
  Fit,
  Fill,
}

class CreatePlaylistScreen extends HookWidget {
  const CreatePlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      DividerVertical(marginVertical: 0),
                      PlaylistTotalDuration()
                    ],
                  ),
                ),
              ];
            },
            body: const PlaylistContents(),
          ),
        ),
      ),
      bottomNavigationBar: const PlaylistBottomContent(),
    );
  }
}
