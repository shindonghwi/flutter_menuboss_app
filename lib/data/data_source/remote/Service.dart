import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uuid/uuid.dart';

import '../../../app/env/Environment.dart';
import '../../../presentation/utils/Common.dart';
import 'BaseApiUtil.dart';
import 'HeaderKey.dart';

class Service {
  static AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();
  static String baseUrl = "${Environment.apiUrl}/${Environment.apiVersion}";

  static Map<String, String> headers = {
    HeaderKey.ContentType: 'application/json',
    HeaderKey.AcceptLanguage: 'en-US',
    HeaderKey.Accept: '*/*',
    HeaderKey.Connection: 'keep-alive',
    HeaderKey.ApplicationTimeZone: 'Asia/Seoul',
  };

  static Future<void> initializeHeaders() async {
    // app version
    addHeader(key: HeaderKey.XAppVersion, value: (await PackageInfo.fromPlatform()).version);

    // unique id
    addHeader(key: HeaderKey.XUniqueId, value: const Uuid().v4());

    // device model
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      addHeader(key: HeaderKey.XDeviceModel, value: androidInfo.model);
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      addHeader(key: HeaderKey.XDeviceModel, value: iosInfo.utsname.machine);
    }
  }

  static addHeader({
    required String key,
    required String value,
  }) {
    if (key == HeaderKey.Authorization) {
      value.isNotEmpty ? headers[key] = "Bearer $value" : headers.remove(key);
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
    String? query,
  }) async {
    try {
      if (await isNetworkAvailable()) {
        final url = Uri.parse('$baseUrl/'
            '${_ServiceTypeHelper.fromString(type)}'
            '${endPoint == null ? "" : "/$endPoint"}'
            '${query == null ? "" : "?$query"}');
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
    } catch (e) {
      return BaseApiUtil.createResponse(_getAppLocalization.get().message_server_error_5xx.toString(), 500);
    }
  }

  static Future<Response> postApi({
    required ServiceType type,
    required String? endPoint,
    required Map<String, dynamic>? jsonBody,
  }) async {
    try {
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
    } catch (e) {
      return BaseApiUtil.createResponse(_getAppLocalization.get().message_server_error_5xx.toString(), 500);
    }
  }

  static Future<Response> postUploadApi({
    required ServiceType type,
    required String? endPoint,
    required File file,
    required Map<String, dynamic> jsonBody,
  }) async {

    try {
      if (await isNetworkAvailable()) {
        final url = Uri.parse('$baseUrl/${_ServiceTypeHelper.fromString(type)}${endPoint == null ? "" : "/$endPoint"}');

        debugPrint('\nrequest Url: $url');
        debugPrint('request header: $headers');

        var request = http.MultipartRequest('POST', url)
          ..headers.addAll(headers)
          ..files.add(await http.MultipartFile.fromPath('file', file.path));

        jsonBody.forEach((key, value) {
          request.fields[key] = value.toString();
        });

        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        debugPrint('\http response statusCode: ${response.statusCode}');
        debugPrint('\http response method: ${response.request?.method.toString()}');
        debugPrint('\http response body: ${response.body}');
        return response;
      } else {
        return BaseApiUtil.createResponse(_getAppLocalization.get().message_network_required.toString(), 406);
      }
    } catch (e) {
      return BaseApiUtil.createResponse(_getAppLocalization.get().message_server_error_5xx.toString(), 500);
    }
  }

  static Future<Response> patchApi({
    required ServiceType type,
    required String? endPoint,
    required Map<String, dynamic>? jsonBody,
  }) async {
    try {
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
    } catch (e) {
      return BaseApiUtil.createResponse(_getAppLocalization.get().message_server_error_5xx.toString(), 500);
    }
  }

  static Future<Response> deleteApi({
    required ServiceType type,
    required String? endPoint,
    required Map<String, dynamic>? jsonBody,
  }) async {
    try {
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
    } catch (e) {
      return BaseApiUtil.createResponse(_getAppLocalization.get().message_server_error_5xx.toString(), 500);
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
  File,
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
    ServiceType.File: "files",
    ServiceType.Schedule: "schedules",
    ServiceType.Validation: "validation"
  };

  static String fromString(ServiceType type) => _stringToEnum[type] ?? "";
}
