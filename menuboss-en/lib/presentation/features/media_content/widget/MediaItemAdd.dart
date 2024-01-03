import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/SimpleMediaContentModel.dart';
import 'package:menuboss/presentation/features/media_content/provider/MediaContentsCartProvider.dart';
import 'package:menuboss_common/components/button/PrimaryFilledButton.dart';
import 'package:menuboss_common/components/loader/LoadImage.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/components/placeholder/PlaceholderType.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/utils/ClickableScale.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/Strings.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/CollectionUtil.dart';
import 'package:menuboss_common/utils/Common.dart';

import '../../main/media/widget/MediaItem.dart';

class MediaItemAdd extends HookConsumerWidget {
  final SimpleMediaContentModel item;
  final VoidCallback onFolderTap;

  const MediaItemAdd({
    super.key,
    required this.item,
    required this.onFolderTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget? iconWidget;
    bool isFolderType = false;
    final mediaCartState = ref.watch(mediaContentsCartProvider);
    final mediaCartManager = ref.read(mediaContentsCartProvider.notifier);

    final isAdded = useState(false);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isAdded.value = mediaCartState.any((existingItem) => existingItem.id == item.id);
      });
      return null;
    }, [mediaCartState]);

    final code = item.type?.toLowerCase();

    switch (code) {
      case "folder":
        iconWidget = LoadSvg(
          path: "assets/imgs/icon_folder.svg",
          width: 60,
          height: 60,
        );
        break;
      default:
        iconWidget = SizedBox(
          width: 60,
          height: 60,
          child: LoadImage(
            url: item.property?.imageUrl,
            type: ImagePlaceholderType.Small,
          ),
        );
    }

    String content = ParseMediaItem.convertTypeSizeFormat(
      context,
      code,
      item.property?.count,
      item.property?.size,
    );

    isFolderType = item.isFolder == true ? true : false;

    return ClickableScale(
      onPressed: isFolderType ? () => onFolderTap.call() : null,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 12, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  iconWidget,
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.name.toString(),
                          style: getTextTheme(context).b2m.copyWith(
                                color: getColorScheme(context).colorGray900,
                              ),
                        ),
                        !CollectionUtil.isNullEmptyFromString(content)
                            ? Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  content,
                                  style: getTextTheme(context).b3r.copyWith(
                                        color: getColorScheme(context).colorGray500,
                                      ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            !isFolderType
                ? Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: PrimaryFilledButton.smallRound100(
                      content: Strings.of(context).commonAdd,
                      isActivated: true,
                      onPressed: () {
                        Toast.showSuccess(
                          context,
                          Strings.of(context).messageAddMediaInPlaylistSuccess,
                        );
                        mediaCartManager.addItem(item);
                      },
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: LoadSvg(
                      path: "assets/imgs/icon_next.svg",
                      width: 24,
                      height: 24,
                      color: getColorScheme(context).colorGray600,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
