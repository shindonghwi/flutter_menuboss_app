import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:menuboss/data/data_source/remote/HeaderKey.dart';
import 'package:menuboss/data/data_source/remote/Service.dart';
import 'package:menuboss/data/models/business/RequestAddressModel.dart';
import 'package:menuboss/data/models/me/ResponseMeInfoModel.dart';
import 'package:menuboss_common/utils/CollectionUtil.dart';
import 'package:riverpod/riverpod.dart';

final meInfoProvider = StateNotifierProvider<MeInfoNotifier, ResponseMeInfoModel?>(
  (_) => MeInfoNotifier(),
);

class MeInfoNotifier extends StateNotifier<ResponseMeInfoModel?> {
  MeInfoNotifier() : super(null);

  void updateMeInfo(ResponseMeInfoModel? meInfo) async {
    if (meInfo == null) {
      FirebaseAuth.instance.signOut();
      await UserApi.instance.logout();
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

  void updateMePhone(String phone) {
    ResponseMeInfoModel meInfo = state!.copyWith(
        profile: state!.profile?.copyWith(
      phone: phone,
    ));
    debugPrint("updateMePhone : $meInfo");
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

  void updateMeBusinessInfo(String title, RequestAddressModel model, String phone) {
    ResponseMeInfoModel meInfo = state!;

    if (!CollectionUtil.isNullEmptyFromString(title)) {
      debugPrint("000updateMeBusinessInfo : $meInfo");
      meInfo = meInfo.copyWith(
        business: meInfo.business!.copyWith(
          title: title,
        ),
      );
      debugPrint("111updateMeBusinessInfo : $meInfo");
    }
    if (!CollectionUtil.isNullEmptyFromString(phone)) {
      meInfo = meInfo.copyWith(
        business: meInfo.business!.copyWith(
          phone: phone,
        ),
      );
    }

    meInfo = meInfo.copyWith(
      business: meInfo.business!.copyWith(
        address: meInfo.business!.address?.copyWith(
          line1: model.line1,
          line2: model.line2,
          postalCode: model.postalCode,
        ),
      ),
    );

    debugPrint("updateMeBusinessInfo : $meInfo");
    state = meInfo;
  }

  ResponseMeInfoModel? getMeInfo() => state;
}
