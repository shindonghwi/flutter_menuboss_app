import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class LoadingView extends HookWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getMediaQuery(context).size.width,
      height: getMediaQuery(context).size.height,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: getColorScheme(context).colorPrimary500,
        ),
      ),
    );
  }
}
