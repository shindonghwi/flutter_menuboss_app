import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:menuboss/data/models/me/ResponseMeInfoModel.dart';
import 'package:riverpod/riverpod.dart';

final MeInfoProvider = StateNotifierProvider<MeInfoNotifier, ResponseMeInfoModel?>(
  (_) => MeInfoNotifier(),
);

class MeInfoNotifier extends StateNotifier<ResponseMeInfoModel?> {
  MeInfoNotifier() : super(null);

  void updateMeInfo(ResponseMeInfoModel? meInfo) async {
    if (meInfo == null) {
      GoogleSignIn().disconnect();
      FirebaseAuth.instance.signOut();
    }
    state = meInfo;
  }

  void updateMeFullName(String name) {
    ResponseMeInfoModel meInfo = state!.copyWith(
      name: name,
    );
    debugPrint("updateMeFullName : ${meInfo.toJson()}");
    state = meInfo;
  }
}
