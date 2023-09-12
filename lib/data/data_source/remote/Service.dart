import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../../app/env/Environment.dart';
import '../../../presentation/utils/Common.dart';
import 'BaseApiUtil.dart';
import 'HeaderKey.dart';

class Service {
  static AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();
  static String baseUrl = "${Environment.apiUrl}/${Environment.apiVersion}";

  static Map<String, String> headers = {
    HeaderKey.ContentType: 'application/json',
    HeaderKey.AcceptLanguage: 'ko-KR',
    HeaderKey.Accept: '*/*',
    HeaderKey.Connection: 'keep-alive',
  };

  static setHeader({
    required String languageCode,
    required String countryCode,
    required String timeZone,
    String token = "",
  }) {
    headers = {
      HeaderKey.ContentType: 'application/json',
      HeaderKey.AcceptLanguage: '$languageCode-$countryCode',
      HeaderKey.Accept: timeZone,
      HeaderKey.Authorization: 'Bearer $token',
    };
    headers.forEach((key, value) {
      debugPrint('headerInfo: $key: $value');
    });
  }

  static addHeader({
    required String key,
    required String value,
  }) {
    if (key == HeaderKey.Authorization) {
      headers[key] = "Bearer $value";
    } else {
      headers[key] = value;
    }

    headers.forEach((key, value) {
      debugPrint('headerInfo: $key: $value');
    });
  }

  static Future<bool> isNetworkAvailable() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.none ? false : true;
  }

  static Future<Response> getApi({
    required ServiceType type,
    required String? endPoint,
  }) async {
    if (await isNetworkAvailable()) {
      final url = Uri.parse('$baseUrl/${_ServiceTypeHelper.fromString(type)}${endPoint == null ? "" : "/$endPoint"}');
      debugPrint('\nrequest Url: $url');
      debugPrint('request header: $headers\n');

      final res = await http.get(
        url,
        headers: headers,
      );
      debugPrint('\http response statusCode: ${res.statusCode}');
      debugPrint('\http response method: ${res.request?.method.toString()}');
      debugPrint('\http response body: ${res.body}');
      return res;
    } else {
      return BaseApiUtil.createResponse(_getAppLocalization.get().message_network_required.toString(), 406);
    }
  }

  static Future<Response> postApi({
    required ServiceType type,
    required String? endPoint,
    required Map<String, dynamic>? jsonBody,
  }) async {
    if (await isNetworkAvailable()) {
      final url = Uri.parse('$baseUrl/${_ServiceTypeHelper.fromString(type)}${endPoint == null ? "" : "/$endPoint"}');
      debugPrint('\nrequest Url: $url');
      debugPrint('request header: $headers');
      debugPrint('request body: $jsonBody\n', wrapWidth: 2048);

      final res = await http.post(
        url,
        headers: headers,
        body: jsonEncode(jsonBody),
      );
      debugPrint('\http response statusCode: ${res.statusCode}');
      debugPrint('\http response method: ${res.request?.method.toString()}');
      debugPrint('\http response body: ${res.body}');
      return res;
    } else {
      return BaseApiUtil.createResponse(_getAppLocalization.get().message_network_required.toString(), 406);
    }
  }

  static Future<Response> patchApi({
    required ServiceType type,
    required String? endPoint,
    required Map<String, dynamic> jsonBody,
  }) async {
    if (await isNetworkAvailable()) {
      final url = Uri.parse('$baseUrl/${_ServiceTypeHelper.fromString(type)}${endPoint == null ? "" : "/$endPoint"}');
      debugPrint('\nrequest Url: $url');
      debugPrint('request header: $headers');
      debugPrint('request body: $jsonBody\n', wrapWidth: 2048);

      final res = await http.patch(
        url,
        headers: headers,
        body: jsonEncode(jsonBody),
      );
      debugPrint('\http response statusCode: ${res.statusCode}');
      debugPrint('\http response method: ${res.request?.method.toString()}');
      debugPrint('\http response body: ${res.body}');
      return res;
    } else {
      return BaseApiUtil.createResponse(_getAppLocalization.get().message_network_required.toString(), 406);
    }
  }

  static Future<Response> deleteApi({
    required ServiceType type,
    required String? endPoint,
    required Map<String, dynamic>? jsonBody,
  }) async {
    if (await isNetworkAvailable()) {
      final url = Uri.parse('$baseUrl/${_ServiceTypeHelper.fromString(type)}${endPoint == null ? "" : "/$endPoint"}');
      debugPrint('\nrequest Url: $url');
      debugPrint('request header: $headers');
      debugPrint('request body: $jsonBody\n', wrapWidth: 2048);

      final res = await http.delete(
        url,
        headers: headers,
        body: jsonEncode(jsonBody),
      );
      debugPrint('\http response statusCode: ${res.statusCode}');
      debugPrint('\http response method: ${res.request?.method.toString()}');
      debugPrint('\http response body: ${res.body}');
      return res;
    } else {
      return BaseApiUtil.createResponse(_getAppLocalization.get().message_network_required.toString(), 406);
    }
  }
}

enum ServiceType {
  Auth,
  Business,
  Canvas,
  Me,
  Media,
  Payment,
  Playlist,
  Device,
  Schedule,
  Validation,
}

class _ServiceTypeHelper {
  static const Map<ServiceType, String> _stringToEnum = {
    ServiceType.Auth: "auth",
    ServiceType.Business: "business",
    ServiceType.Canvas: "canvases",
    ServiceType.Me: "me",
    ServiceType.Media: "media",
    ServiceType.Payment: "payments",
    ServiceType.Playlist: "playlists",
    ServiceType.Device: "screens",
    ServiceType.Schedule: "schedules",
    ServiceType.Validation: "validation"
  };

  static String fromString(ServiceType type) => _stringToEnum[type] ?? "";
}
