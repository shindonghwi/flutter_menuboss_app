import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:menuboss/data/models/base/ApiResponse.dart';

import '../../models/base/ApiListResponse.dart';

class BaseApiUtil {
  static ApiResponse? isErrorStatusCode(Response res) {
    if (res.statusCode >= 500) {
      return ApiResponse(
        status: res.statusCode,
        message: "An error occurred while loading data.\nPlease use it again",
        data: null,
      );
    } else if (res.statusCode == 406) {
      return ApiResponse(
        status: res.statusCode,
        message: "The network connection is unstable",
        data: null,
      );
    }
    return null;
  }

  static ApiResponse<T> errorResponse<T>({int status = 500, required String message}) {
    return ApiResponse(
      status: status,
      message: message,
      data: null,
    );
  }

  static ApiListResponse<T> errorListResponse<T>({int status = 500, required String message}) {
    return ApiListResponse(status: status, message: message, list: null, count: 0);
  }

  static http.Response createResponse(String body, int statusCode) {
    return http.Response(utf8.encode(body).toString(), statusCode);
  }
}
