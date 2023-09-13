import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:menuboss/data/models/me/ResponseMeInfoModel.dart';
import 'package:riverpod/riverpod.dart';

final MeInfoProvider = StateNotifierProvider<MeInfoNotifier, ResponseMeInfoModel?>(
  (_) => MeInfoNotifier(),
);

class MeInfoNotifier extends StateNotifier<ResponseMeInfoModel?> {
  MeInfoNotifier() : super(null);

  void updateMeInfo(ResponseMeInfoModel? meInfo) async {
    if (meInfo == null) {
      FirebaseAuth.instance.signOut();
    }
    debugPrint("updateMeInfo : $meInfo");
    state = meInfo;
  }

  void updateMeFullName(String name) {
    ResponseMeInfoModel meInfo = state!.copyWith(
      name: name,
    );
    debugPrint("updateMeFullName : $meInfo");
    state = meInfo;
  }
}
