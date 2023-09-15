import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/SimpleMediaContentModel.dart';
import 'package:menuboss/presentation/components/button/NeutralFilledButton.dart';
import 'package:menuboss/presentation/components/button/PrimaryFilledButton.dart';
import 'package:menuboss/presentation/components/loader/LoadImage.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/components/utils/ClickableScale.dart';
import 'package:menuboss/presentation/features/media_content/provider/MediaContentsCartProvider.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

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
    final mediaCartState = ref.watch(MediaContentsCartProvider);
    final mediaCartProvider = ref.read(MediaContentsCartProvider.notifier);

    final isAdded = useState(false);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isAdded.value = mediaCartState.any((element) => element == item);
      });
      return null;
    },[mediaCartState]);

    final code = item.type?.toLowerCase();

    switch (code) {
      case "folder":
        iconWidget = SvgPicture.asset(
          "assets/imgs/icon_folder.svg",
          width: 60,
          height: 60,
        );
      default:
        iconWidget = SizedBox(
          width: 60,
          height: 60,
          child: LoadImage(url: item.thumbnailUrl, type: ImagePlaceholderType.Small),
        );
    }

    String content = "";
    if (code == "image" || code == "video") {
      isFolderType = false;
      content = "$code - (${StringUtil.formatBytesToMegabytes(item.size ?? 0)})";
    } else if (code == "folder") {
      isFolderType = true;
      content = "${item.count} File (${StringUtil.formatBytesToMegabytes(item.size ?? 0)})";
    }

    return ClickableScale(
      onPressed: isFolderType ? () => onFolderTap.call() : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
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
                          style: getTextTheme(context).b1sb.copyWith(
                                color: getColorScheme(context).colorGray900,
                              ),
                        ),
                        !CollectionUtil.isNullEmptyFromString(content)
                            ? Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  content,
                                  style: getTextTheme(context).b3m.copyWith(
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
            !isAdded.value
                ? PrimaryFilledButton.extraSmallRound100(
                    content: getAppLocalizations(context).common_add,
                    isActivated: true,
                    onPressed: () => mediaCartProvider.addItem(item),
                  )
                : NeutralFilledButton.extraSmallRound100(
                    content: getAppLocalizations(context).common_add,
                    isActivated: true,
                    onPressed: () => mediaCartProvider.removeItem(item),
                  ),
          ],
        ),
      ),
    );
  }
}
