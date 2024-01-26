import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/data/models/business/ResponseBusinessMemberModel.dart';
import 'package:menuboss/data/models/business/ResponseRoleModel.dart';
import 'package:menuboss_common/components/bottom_sheet/BottomSheetModifySelector.dart';
import 'package:menuboss_common/components/commons/MoreButton.dart';
import 'package:menuboss_common/components/loader/LoadImage.dart';
import 'package:menuboss_common/components/placeholder/PlaceholderType.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';

class RoleItem extends HookWidget {
  final ResponseRoleModel item;

  const RoleItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 72,
      padding: const EdgeInsets.only(left: 24, right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                    item.updatedDate,
                    style: getTextTheme(context).c1m.copyWith(
                          color: getColorScheme(context).colorGray500,
                        ),
                  ),
                ],
              ),
            ],
          ),
          MoreButton(
            items: const [ModifyType.Edit, ModifyType.Delete],
            onSelected: (type, text) {
              if (type == ModifyType.Delete) {
              } else if (type == ModifyType.Rename) {}
            },
          )
        ],
      ),
    );
  }
}
