import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../ui/colors.dart';
import '../../utils/Common.dart';

class LinearAnimationProgressBar extends HookWidget {
  final double percentage;

  const LinearAnimationProgressBar({
    Key? key,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: const Duration(milliseconds: 600));
    final animation = useAnimation(Tween<double>(begin: 0, end: percentage).animate(controller));

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return VisibilityDetector(
          key: const Key('visible_detector'),
          onVisibilityChanged: (info) {
            if (info.visibleFraction == 1) {
              controller.forward();
            }
          },
          child: Container(
            width: double.infinity,
            height: 8,
            decoration: BoxDecoration(
              color: getColorScheme(context).colorGray100,
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 8,
                width: animation * constraints.maxWidth,
                decoration: BoxDecoration(
                  color: getColorScheme(context).colorPrimary500,
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
