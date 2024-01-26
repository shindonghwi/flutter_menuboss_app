import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/business/ResponseBusinessMemberModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss_common/components/bottom_sheet/BottomSheetModifySelector.dart';
import 'package:menuboss_common/components/commons/MoreButton.dart';
import 'package:menuboss_common/components/loader/LoadImage.dart';
import 'package:menuboss_common/components/placeholder/PlaceholderType.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';

class TeamMemberItem extends HookConsumerWidget {
  final ResponseBusinessMemberModel item;
  final VoidCallback onDeleted;

  const TeamMemberItem({
    super.key,
    required this.item,
    required this.onDeleted,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void goToCreateTeamMember({ResponseBusinessMemberModel? item}) async {
      Navigator.push(
        context,
        nextSlideHorizontalScreen(
          RoutingScreen.TeamCreate.route,
          parameter: item,
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: 80,
      padding: const EdgeInsets.only(left: 24, right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 48,
                height: 48,
                child: LoadImage(
                  borderRadius: 100,
                  url: "",
                  type: ImagePlaceholderType.Size_48,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.name,
                    style: getTextTheme(context).b3m.copyWith(
                          color: getColorScheme(context).colorGray900,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.role?.name ?? "-",
                    style: getTextTheme(context).c1m.copyWith(
                          color: getColorScheme(context).colorGray500,
                        ),
                  ),
                ],
              ),
            ],
          ),
          if (item.role?.roleId != null)
            MoreButton(
              items: const [ModifyType.Edit, ModifyType.Delete],
              onSelected: (type, text) {
                if (type == ModifyType.Edit) {
                  goToCreateTeamMember(item: item);
                } else if (type == ModifyType.Delete) {
                  onDeleted.call();
                }
              },
            )
        ],
      ),
    );
  }
}
