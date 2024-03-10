import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/business/ResponseRoleModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss/navigation/Route.dart';
import 'package:menuboss_common/components/bottom_sheet/BottomSheetModifySelector.dart';
import 'package:menuboss_common/components/commons/MoreButton.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';

import '../provider/RoleListProvider.dart';

class RoleItem extends HookConsumerWidget {
  final ResponseRoleModel item;
  final VoidCallback onDeleted;

  const RoleItem({
    super.key,
    required this.item,
    required this.onDeleted,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roleListManager = ref.read(roleListProvider.notifier);

    void goToCreateRole({ResponseRoleModel? item}) async {
      try {
        final isUpdated = await Navigator.push(
          context,
          nextSlideHorizontalScreen(
            RoutingScreen.RoleCreate.route,
            parameter: item,
          ),
        );
        if (isUpdated) {
          roleListManager.requestGetRoles();
        }
      } catch (e) {

      }
    }


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
              if (type == ModifyType.Edit) {
                goToCreateRole(item: item);
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
