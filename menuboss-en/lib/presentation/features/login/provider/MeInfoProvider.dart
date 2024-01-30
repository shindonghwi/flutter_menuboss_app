import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:menuboss/data/data_source/remote/HeaderKey.dart';
import 'package:menuboss/data/data_source/remote/Service.dart';
import 'package:menuboss/data/models/me/ResponseMeInfoModel.dart';
import 'package:menuboss_common/utils/CollectionUtil.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../data/models/business/RequestAddressModel.dart';
import '../../../../data/models/me/ResponseMeBusinessAddress.dart';

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

  void updateMePhone(String country, String phone) {
    ResponseMeInfoModel meInfo = state!.copyWith(
        profile: state!.profile?.copyWith(
      phone: state!.profile?.phone?.copyWith(
        country: country,
        phone: phone,
      ),
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
      meInfo = meInfo.copyWith(
        business: meInfo.business!.copyWith(
          title: title,
        ),
      );
    }
    if (!CollectionUtil.isNullEmptyFromString(phone)) {
      meInfo = meInfo.copyWith(
        business: meInfo.business!.copyWith(
          phone: meInfo.business?.phone?.copyWith(
            phone: phone,
          ),
        ),
      );
    }

    meInfo = meInfo.copyWith(
      business: meInfo.business!.copyWith(
        address: meInfo.business!.address == null
            ? ResponseMeBusinessAddress(
                line1: model.line1,
                line2: model.line2,
                postalCode: model.postalCode,
                country: model.country,
                state: model.state,
                city: model.city,
              )
            : meInfo.business!.address?.copyWith(
                line1: model.line1,
                line2: model.line2,
                postalCode: model.postalCode,
                country: model.country,
                state: model.state,
                city: model.city,
              ),
      ),
    );

    debugPrint("updateMeBusinessInfo : $meInfo");
    state = meInfo;
  }

  ResponseMeInfoModel? getMeInfo() => state;
}
