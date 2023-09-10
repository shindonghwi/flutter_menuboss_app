import 'package:flutter/material.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/features/main/playlists/model/PlayListModel.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class PlayListItem extends StatelessWidget {
  final PlayListModel item;
  final GlobalKey<AnimatedListState> listKey;

  const PlayListItem({
    super.key,
    required this.item,
    required this.listKey,
  });

  @override
  Widget build(BuildContext context) {

    void goToApplyToScreen(){
      Navigator.push(
        context,
        nextSlideScreen(RoutingScreen.ApplyScreen.route),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ImagePlaceholder(type: ImagePlaceholderType.Normal),
              const SizedBox(width: 16),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.name,
                    style: getTextTheme(context).b2sb.copyWith(
                          color: getColorScheme(context).colorGray900,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Updated: ${item.updatedAt}",
                    style: getTextTheme(context).c1m.copyWith(
                          color: getColorScheme(context).colorGray500,
                        ),
                  ),
                ],
              ),
            ],
          ),
          PrimaryFilledButton.extraSmallRound100(
            content: getAppLocalizations(context).common_apply,
            isActivated: true,
            onPressed: () {
              goToApplyToScreen();
            },
          )
        ],
      ),
    );
  }
}
