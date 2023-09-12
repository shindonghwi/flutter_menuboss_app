import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/components/bottom_sheet/BottomSheetModifySelector.dart';
import 'package:menuboss/presentation/components/commons/MoreButton.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/components/popup/CommonPopup.dart';
import 'package:menuboss/presentation/components/popup/PopupDelete.dart';
import 'package:menuboss/presentation/components/popup/PopupRename.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class PlaylistContentItem extends HookWidget {
  final int item;
  final ValueNotifier<List<int>> items;

  const PlaylistContentItem({
    super.key,
    required this.item,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final isDeleting = useState<bool>(false);
    final animationController = useAnimationController(duration: const Duration(milliseconds: 300), initialValue: 1.0);

    useEffect(() {
      if (isDeleting.value) {
        animationController.reverse().then((_) {
          items.value = List.from(items.value)..remove(item);
        });
      }
      return;
    }, [isDeleting.value]);

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-0.6, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
      ),
      child: FadeTransition(
        opacity: animationController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ReorderableDragStartListener(
                    index: item,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        "assets/imgs/icon_alignment.svg",
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          getColorScheme(context).colorGray500,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const ImagePlaceholder(type: ImagePlaceholderType.Small),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/imgs/icon_image.svg",
                                  width: 20,
                                  height: 20,
                                  colorFilter: ColorFilter.mode(
                                    getColorScheme(context).colorGray900,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "File name ${item}",
                                    style: getTextTheme(context).b2sb.copyWith(
                                          color: getColorScheme(context).colorGray900,
                                        ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                "00:00:00",
                                style: getTextTheme(context).c1sb.copyWith(
                                      color: getColorScheme(context).colorGray500,
                                    ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onLongPress: () {},
                child: MoreButton(
                  items: const [
                    ModifyType.ChangeDuration,
                    ModifyType.Delete,
                  ],
                  onSelected: (type, text) {
                    if (type == ModifyType.ChangeDuration){

                    }else if (type == ModifyType.Delete){
                      CommonPopup.showPopup(
                        context,
                        child: PopupDelete(
                          onClicked: (isCompleted) {
                            if (isCompleted) {
                              isDeleting.value = true;
                            }
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
