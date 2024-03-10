import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uuid/uuid.dart';

import '../../../app/env/Environment.dart';
import 'BaseApiUtil.dart';
import 'HeaderKey.dart';

class Service {
  static String baseUrl = "${Environment.apiUrl}/${Environment.apiVersion}";

  static const _apiTimeOut = Duration(seconds: 10);
  static const _apiUploadTimeOut = Duration(seconds: 30);

  static Map<String, String> headers = {
    HeaderKey.ContentType: 'application/json',
    HeaderKey.AcceptLanguage: 'ko-KR',
    HeaderKey.Accept: '*/*',
    HeaderKey.Connection: 'keep-alive',
    HeaderKey.ApplicationTimeZone: '',
    HeaderKey.XClientId: '', //  미국 AND - MBGA,  미국 IOS - MBGI, 한국 AND - MBKA, 한국 IOS - MBKI
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
      final isPhysicalDevice = androidInfo.isPhysicalDevice ? 'Physical' : 'Emulator';
      String xDeviceModel =
          "Android ${androidInfo.version.release} (SDK ${androidInfo.version.sdkInt}; "
          "Model ${androidInfo.model}; Brand ${androidInfo.brand}; Device ${androidInfo.device}; "
          "Product ${androidInfo.product}; $isPhysicalDevice)";
      debugPrint('AndroidInfo: $xDeviceModel');
      addHeader(key: HeaderKey.XDeviceModel, value: xDeviceModel);
      addHeader(key: HeaderKey.XClientId, value: "MBKA"); // 한국 AOS
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      final isPhysicalDevice = iosInfo.isPhysicalDevice ? 'Physical' : 'Simulator';
      String xDeviceModel =
          "${iosInfo.systemName}/${iosInfo.systemVersion} (${iosInfo.localizedModel}; "
          "${iosInfo.utsname.machine}; ${iosInfo.model}; $isPhysicalDevice)";
      debugPrint('iosInfo: $xDeviceModel');
      addHeader(key: HeaderKey.XDeviceModel, value: xDeviceModel);
      addHeader(key: HeaderKey.XClientId, value: "MBKI"); // 한국 iOS
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

        final res = await http
            .get(
              url,
              headers: headers,
            )
            .timeout(_apiTimeOut);
        debugPrint('\nhttp response statusCode: ${res.statusCode}');
        debugPrint('\nhttp response method: ${res.request?.method.toString()}');
        debugPrint('\nhttp response body: ${res.body}');
        return res;
      } else {
        return BaseApiUtil.createResponse(
          "네트워크 연결이 불안정합니다\n잠시 후에 다시 시도해주세요",
          406,
        );
      }
    } catch (e) {
      if (e is TimeoutException) {
        debugPrint('\nRequest timed out');
        return BaseApiUtil.createResponse(
          "작업이 너무 지연되고 있습니다.\n잠시 후에 다시 시도해주세요",
          408,
        );
      } else {
        debugPrint('\nhttp response error: $e');
        return BaseApiUtil.createResponse(
          "일시적인 장애가 발생하였습니다\n잠시 후 다시 시도해주세요",
          500,
        );
      }
    }
  }

  static Future<Response> postApi({
    required ServiceType type,
    required String? endPoint,
    required Map<String, dynamic>? jsonBody,
  }) async {
    try {
      if (await isNetworkAvailable()) {
        final url = Uri.parse(
            '$baseUrl/${_ServiceTypeHelper.fromString(type)}${endPoint == null ? "" : "/$endPoint"}');
        debugPrint('\nrequest Url: $url');
        debugPrint('\nrequest header: $headers');
        debugPrint('\nrequest body: $jsonBody\n', wrapWidth: 2048);

        final res = await http
            .post(
              url,
              headers: headers,
              body: jsonEncode(jsonBody),
            )
            .timeout(_apiTimeOut);
        debugPrint('\nhttp response statusCode: ${res.statusCode}');
        debugPrint('\nhttp response method: ${res.request?.method.toString()}');
        debugPrint('\nhttp response body: ${res.body}');
        return res;
      } else {
        return BaseApiUtil.createResponse(
          "네트워크 연결이 불안정합니다\n잠시 후에 다시 시도해주세요".toString(),
          406,
        );
      }
    } catch (e) {
      if (e is TimeoutException) {
        debugPrint('\nRequest timed out');
        return BaseApiUtil.createResponse(
          "작업이 너무 지연되고 있습니다.\n잠시 후에 다시 시도해주세요",
          408,
        );
      } else {
        debugPrint('\nhttp esponse error: $e');
        return BaseApiUtil.createResponse(
          "일시적인 장애가 발생하였습니다\n잠시 후 다시 시도해주세요",
          500,
        );
      }
    }
  }

  static Future<http.Response> postUploadApi({
    required ServiceType type,
    required String? endPoint,
    required File file,
    required Map<String, dynamic> jsonBody,
    StreamController<double>? uploadProgressController,
  }) async {
    try {
      if (await isNetworkAvailable()) {
        final url = Uri.parse(
            '$baseUrl/${_ServiceTypeHelper.fromString(type)}${endPoint == null ? "" : "/$endPoint"}');

        debugPrint('\nrequest Url: $url');
        debugPrint('\nrequest header: $headers');

        var request = http.MultipartRequest('POST', url)
          ..headers.addAll(headers)
          ..fields.addAll(jsonBody.map((key, value) => MapEntry(key, value.toString())))
          ..files.add(
            http.MultipartFile('file', file.openRead(), file.lengthSync(),
                filename: file.path.split('/').last),
          );

        var client = http.Client();

        var totalByteLength = file.lengthSync();
        int bytesUploaded = 0;
        try {
          await for (var data in file.openRead()) {
            bytesUploaded += data.length;
            uploadProgressController?.sink.add(bytesUploaded / totalByteLength);
          }

          var streamedResponse = await client.send(request).timeout(_apiUploadTimeOut);
          var response = await http.Response.fromStream(streamedResponse);
          debugPrint('\nhttp response statusCode: ${response.statusCode}');
          debugPrint('\nhttp response method: ${response.request?.method.toString()}');
          debugPrint('\nhttp response body: ${response.body}');
          uploadProgressController?.close();
          return response;
        } catch (e) {
          debugPrint('\nNetwork send error: $e');
          uploadProgressController?.close();
          return BaseApiUtil.createResponse(
            "네트워크 연결이 불안정합니다\n잠시 후에 다시 시도해주세요",
            406,
          );
        }
      } else {
        return BaseApiUtil.createResponse(
          "네트워크 연결이 불안정합니다\n잠시 후에 다시 시도해주세요",
          406,
        );
      }
    } catch (e) {
      if (e is TimeoutException) {
        debugPrint('\nRequest timed out');
        return BaseApiUtil.createResponse(
          "작업이 너무 지연되고 있습니다.\n잠시 후에 다시 시도해주세요",
          408,
        );
      } else {
        debugPrint('\nhttp esponse error: $e');
        return BaseApiUtil.createResponse(
          "일시적인 장애가 발생하였습니다\n잠시 후 다시 시도해주세요",
          500,
        );
      }
    }
  }

  static Future<Response> patchApi({
    required ServiceType type,
    required String? endPoint,
    required Map<String, dynamic>? jsonBody,
  }) async {
    try {
      if (await isNetworkAvailable()) {
        final url = Uri.parse(
            '$baseUrl/${_ServiceTypeHelper.fromString(type)}${endPoint == null ? "" : "/$endPoint"}');
        debugPrint('\nrequest Url: $url');
        debugPrint('\nrequest header: $headers');
        debugPrint('\nrequest body: $jsonBody\n', wrapWidth: 2048);

        final res = await http
            .patch(
              url,
              headers: headers,
              body: jsonEncode(jsonBody),
            )
            .timeout(_apiTimeOut);
        debugPrint('\nhttp response statusCode: ${res.statusCode}');
        debugPrint('\nhttp response method: ${res.request?.method.toString()}');
        debugPrint('\nhttp response body: ${res.body}');
        return res;
      } else {
        return BaseApiUtil.createResponse(
          "네트워크 연결이 불안정합니다\n잠시 후에 다시 시도해주세요",
          406,
        );
      }
    } catch (e) {
      if (e is TimeoutException) {
        debugPrint('\nRequest timed out');
        return BaseApiUtil.createResponse(
          "작업이 너무 지연되고 있습니다.\n잠시 후에 다시 시도해주세요",
          408,
        );
      } else {
        debugPrint('\nhttp esponse error: $e');
        return BaseApiUtil.createResponse(
          "일시적인 장애가 발생하였습니다\n잠시 후 다시 시도해주세요",
          500,
        );
      }
    }
  }

  static Future<Response> deleteApi({
    required ServiceType type,
    required String? endPoint,
    required Map<String, dynamic>? jsonBody,
  }) async {
    try {
      if (await isNetworkAvailable()) {
        final url = Uri.parse(
            '$baseUrl/${_ServiceTypeHelper.fromString(type)}${endPoint == null ? "" : "/$endPoint"}');
        debugPrint('\nrequest Url: $url');
        debugPrint('\nrequest header: $headers');
        debugPrint('\nrequest body: $jsonBody\n', wrapWidth: 2048);

        final res = await http
            .delete(
              url,
              headers: headers,
              body: jsonEncode(jsonBody),
            )
            .timeout(_apiTimeOut);
        debugPrint('\nhttp response statusCode: ${res.statusCode}');
        debugPrint('\nhttp response method: ${res.request?.method.toString()}');
        debugPrint('\nhttp response body: ${res.body}');
        return res;
      } else {
        return BaseApiUtil.createResponse(
          "네트워크 연결이 불안정합니다\n잠시 후에 다시 시도해주세요",
          406,
        );
      }
    } catch (e) {
      if (e is TimeoutException) {
        debugPrint('\nRequest timed out');
        return BaseApiUtil.createResponse(
          "작업이 너무 지연되고 있습니다.\n잠시 후에 다시 시도해주세요",
          408,
        );
      } else {
        debugPrint('\nhttp esponse error: $e');
        return BaseApiUtil.createResponse(
          "일시적인 장애가 발생하였습니다\n잠시 후 다시 시도해주세요",
          500,
        );
      }
    }
  }
}

enum ServiceType {
  App,
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
    ServiceType.App: "app",
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
