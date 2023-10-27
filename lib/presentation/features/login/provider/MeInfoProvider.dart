import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:menuboss/data/data_source/remote/HeaderKey.dart';
import 'package:menuboss/data/data_source/remote/Service.dart';
import 'package:menuboss/data/models/me/ResponseMeInfoModel.dart';
import 'package:riverpod/riverpod.dart';

final meInfoProvider = StateNotifierProvider<MeInfoNotifier, ResponseMeInfoModel?>(
  (_) => MeInfoNotifier(),
);

class MeInfoNotifier extends StateNotifier<ResponseMeInfoModel?> {
  MeInfoNotifier() : super(null);

  void updateMeInfo(ResponseMeInfoModel? meInfo) async {
    if (meInfo == null) {
      FirebaseAuth.instance.signOut();
    }
    Service.addHeader(key: HeaderKey.XUserId, value: meInfo?.memberId.toString() ?? "");
    debugPrint("updateMeInfo : $meInfo");
    state = meInfo;
  }

  void updateMeFullName(String name) {
    ResponseMeInfoModel meInfo = state!.copyWith(
      profile: state!.profile?.copyWith(
        name: name,
      ),
    );
    debugPrint("updateMeFullName : $meInfo");
    state = meInfo;
  }

  void updateMeProfileImage(String imageUrl) {
    ResponseMeInfoModel meInfo = state!.copyWith(
      profile: state!.profile?.copyWith(
        imageUrl: imageUrl,
      ),
    );
    debugPrint("updateMeProfileImage : $meInfo");
    state = meInfo;
  }

  ResponseMeInfoModel? getMeInfo() => state;
}
