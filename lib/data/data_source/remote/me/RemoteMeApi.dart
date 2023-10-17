import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:menuboss/data/models/base/ApiResponse.dart';
import 'package:menuboss/data/models/me/RequestMeJoinModel.dart';
import 'package:menuboss/data/models/me/ResponseMeAuthorization.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import '../../../models/me/ResponseMeInfoModel.dart';
import '../BaseApiUtil.dart';
import '../Service.dart';

class RemoteMeApi {
  RemoteMeApi();

  AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();

  /// 내 정보 요청
  Future<ApiResponse<ResponseMeInfoModel>> getMe() async {
    final response = await Service.getApi(
      type: ServiceType.Me,
      endPoint: null,
    );

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiResponse(
        status: errorResponse.status,
        message: errorResponse.message,
        data: null,
      );
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
        (json) => ResponseMeInfoModel.fromJson(json),
      );
    }
  }

  /// Owner 이름 수정
  Future<ApiResponse<void>> patchName(String name) async {
    final response = await Service.patchApi(
      type: ServiceType.Me,
      endPoint: "name",
      jsonBody: {"name": name},
    );

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiResponse(
        status: errorResponse.status,
        message: errorResponse.message,
        data: null,
      );
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
        (json) {},
      );
    }
  }

  /// 이메일 회원가입
  Future<ApiResponse<ResponseMeAuthorization>> postJoin(RequestMeJoinModel model) async {
    final response = await Service.postApi(
      type: ServiceType.Me,
      endPoint: "join",
      jsonBody: model.toJson(),
    );

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiResponse(
        status: errorResponse.status,
        message: errorResponse.message,
        data: null,
      );
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
            (json) => ResponseMeAuthorization.fromJson(json),
      );
    }
  }
}
