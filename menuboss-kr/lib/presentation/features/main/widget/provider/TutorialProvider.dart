import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss_common/ui/tutorial/model/TutorialKey.dart';
import 'package:menuboss_common/utils/dto/Pair.dart';

final tutorialProvider = StateNotifierProvider<TutorialNotifier, Pair<TutorialKey, double>>(
  (_) => TutorialNotifier(),
);

class TutorialNotifier extends StateNotifier<Pair<TutorialKey, double>> {
  TutorialNotifier() : super(Pair(TutorialKey.Idle, 0.0));

  void change(TutorialKey? key, double opacity) async {
    state = Pair(key ?? state.first, opacity);
  }
}
