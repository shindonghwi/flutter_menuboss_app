import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss/presentation/components/blank/BlankMessage.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/components/utils/ClickableScale.dart';
import 'package:menuboss/presentation/features/apply_screen/widget/ApplyScreenItem.dart';
import 'package:menuboss/presentation/features/main/devices/model/DeviceListModel.dart';
import 'package:menuboss/presentation/features/main/devices/provider/DeviceListProvider.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/CustomHook.dart';

class ApplyToScreen extends HookConsumerWidget {
  const ApplyToScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listKey = useState(CustomHook.useGlobalKey<AnimatedListState>()).value;
    final items = ref.watch(deviceListProvider(listKey));
    final listProvider = ref.read(deviceListProvider(listKey).notifier);

    useEffect(() {
      void generateItems(int count) {
        for (int i = 0; i < count; i++) {
          listProvider.addItem(DeviceListModel(null, "New Screen $i", "Schedule Name $i", "2021.09.08"));
        }
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        generateItems(10);
      });
      return null;
    }, []);

    return BaseScaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopBarIconTitleNone(
              content: getAppLocalizations(context).apply_screen_title,
            ),
            items.isNotEmpty
                ? Expanded(
                    child: Stack(
                      children: [
                        AnimatedList(
                          key: listProvider.listKey,
                          initialItemCount: items.length,
                          padding: const EdgeInsets.only(bottom: 80),
                          itemBuilder: (context, index, animation) {
                            return ClickableScale(
                              onPressed: () {},
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, -0.15),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: FadeTransition(
                                  opacity: animation,
                                  child: ApplyScreenItem(),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: BlankMessage(
                      type: BlankMessageType.NEW_PLAYLIST,
                      onPressed: () {},
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
