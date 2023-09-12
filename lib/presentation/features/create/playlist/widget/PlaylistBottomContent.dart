import 'package:flutter/material.dart';
import 'package:menuboss/presentation/components/button/NeutralLineButton.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class PlaylistBottomContent extends StatelessWidget {
  const PlaylistBottomContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  isActivated: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
