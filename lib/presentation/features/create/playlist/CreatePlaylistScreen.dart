import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/components/appbar/TopBarNoneTitleIcon.dart';
import 'package:menuboss/presentation/components/blank/BlankMessage.dart';
import 'package:menuboss/presentation/components/divider/DividerVertical.dart';
import 'package:menuboss/presentation/components/textfield/OutlineTextField.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _InputName(),
            _Settings(),
            DividerVertical(marginVertical: 12),
            Container(
              margin: const EdgeInsets.only(top: 95),
              child: BlankMessage(
                type: BlankMessageType.ADD_CONTENT,
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _InputName extends HookWidget {
  const _InputName({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16,
      ),
      child: OutlineTextField.small(
        controller: useTextEditingController(),
        hint: getAppLocalizations(context).popup_rename_playlist_hint,
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.text,
        showPwVisibleButton: false,
        showSuffixStatusIcon: false,
        onChanged: (text) {},
      ),
    );
  }
}

class _Settings extends HookWidget {
  const _Settings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final directionType = useState(PlaylistSettingType.Horizontal);
    final scaleType = useState(PlaylistSettingType.Fit);

    return Column(
      children: [
        Clickable(
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getAppLocalizations(context).common_settings,
                  style: getTextTheme(context).b2sb.copyWith(
                        color: getColorScheme(context).colorGray900,
                      ),
                ),
                SvgPicture.asset(
                  "assets/imgs/icon_down.svg",
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    getColorScheme(context).colorGray900,
                    BlendMode.srcIn,
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    _SettingSelectableIcon(
                      iconPath: "assets/imgs/icon_horizontal_line.svg",
                      iconText: getAppLocalizations(context).common_horizontal,
                      onPressed: () => directionType.value = PlaylistSettingType.Horizontal,
                    ),
                    const SizedBox(height: 18),
                    _SettingSelectableIcon(
                      iconPath: "assets/imgs/icon_vertical_line.svg",
                      iconText: getAppLocalizations(context).common_vertical,
                      onPressed: () => directionType.value = PlaylistSettingType.Vertical,
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 64,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                color: getColorScheme(context).colorGray300,
              ),
              Expanded(
                child: Column(
                  children: [
                    _SettingSelectableIcon(
                      iconPath: "assets/imgs/icon_fit.svg",
                      iconText: getAppLocalizations(context).common_fit,
                      onPressed: () => directionType.value = PlaylistSettingType.Fit,
                    ),
                    const SizedBox(height: 18),
                    _SettingSelectableIcon(
                      iconPath: "assets/imgs/icon_fill.svg",
                      iconText: getAppLocalizations(context).common_fill,
                      onPressed: () => directionType.value = PlaylistSettingType.Fill,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _SettingSelectableIcon extends StatelessWidget {
  final String iconPath;
  final String iconText;
  final VoidCallback onPressed;

  const _SettingSelectableIcon({
    super.key,
    required this.iconPath,
    required this.iconText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                getColorScheme(context).colorGray900,
                BlendMode.srcIn,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                iconText,
                style: getTextTheme(context).b3sb.copyWith(
                      color: getColorScheme(context).colorGray900,
                    ),
              ),
            ),
          ],
        ),
        Clickable(
          onPressed: () => onPressed.call(),
          child: SvgPicture.asset(
            iconPath,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              getColorScheme(context).colorGray900,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }
}
