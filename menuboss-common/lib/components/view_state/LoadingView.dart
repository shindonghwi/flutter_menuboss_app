import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../utils/Common.dart';
import '../loader/LoadLottie.dart';

class LoadingView extends HookWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getMediaQuery(context).size.width,
      height: getMediaQuery(context).size.height,
      child: const Center(
        child: LoadLottie(
          path: "assets/motions/loading.json",
          width: 48,
          height: 48,
        ),
      ),
    );
  }
}
