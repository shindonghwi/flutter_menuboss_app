import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import 'MediaItemAdd.dart';

class MediaTabFolder extends HookWidget {
  final PageController pageController;
  final VoidCallback onPressed;

  const MediaTabFolder({
    super.key,
    required this.pageController,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
    // final items = useState<List<MediaModel>>([]);
    //
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Clickable(
    //       onPressed: () => onPressed.call(),
    //       child: Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    //         child: Row(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             SvgPicture.asset(
    //               "assets/imgs/icon_back.svg",
    //               width: 16,
    //               height: 16,
    //               colorFilter: ColorFilter.mode(
    //                 getColorScheme(context).colorGray900,
    //                 BlendMode.srcIn,
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.only(left: 8.0),
    //               child: Text(
    //                 "Back",
    //                 style: getTextTheme(context).b3sb.copyWith(
    //                       color: getColorScheme(context).colorGray900,
    //                     ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     Expanded(
    //       child: ListView.builder(
    //         padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    //         itemCount: items.value.length,
    //         itemBuilder: (context, index) {
    //           return MediaItemAdd(item: items.value[index], onFolderTap: () {});
    //         },
    //       ),
    //     ),
    //   ],
    // );
  }
}
