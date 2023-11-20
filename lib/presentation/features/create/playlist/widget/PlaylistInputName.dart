import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/components/textfield/OutlineTextField.dart';
import 'package:menuboss/presentation/features/create/playlist/provider/PlaylistSaveInfoProvider.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class PlaylistInputName extends HookConsumerWidget {
  final String initTitle;

  const PlaylistInputName({
    super.key,
    required this.initTitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saveManager = ref.read(playlistSaveInfoProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getAppLocalizations(context).common_title,
            style: getTextTheme(context).b3b.copyWith(
                  color: getColorScheme(context).colorGray900,
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: OutlineTextField.small(
              controller: useTextEditingController(text: initTitle),
              hint: getAppLocalizations(context).popup_rename_playlist_hint,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.text,
              showPwVisibleButton: false,
              showSuffixStatusIcon: false,
              onChanged: (name) => saveManager.changeName(name),
            ),
          ),
        ],
      ),
    );
  }
}