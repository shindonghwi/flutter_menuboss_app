import 'package:flutter/cupertino.dart';
import 'package:menuboss/data/models/base/PageResponse.dart';

class ApiListResponse<T> {
  final int status;
  final String message;
  final PageResponse? page;
  final T? list;
  final int? count;

  ApiListResponse({
    required this.status,
    required this.message,
    required this.list,
    required this.count,
    this.page,
  });

  factory ApiListResponse.fromJson(
      Map<String, dynamic>? json,
      T Function(dynamic) fromJsonT,
      ) {

    debugPrint('ApiListResponse.fromJson: $json');
    try {
      return ApiListResponse(
        status: json!['status'] as int,
        message: json['message'] as String,
        page: json['page'] == null ? null : PageResponse.fromJson(json['page']),
        list: fromJsonT(json['list']),
        count: json['count'] as int?,
      );
    } catch (e) {
      debugPrint('Error parsing JSON: ${e.toString()}}');
      return ApiListResponse(
        status: json!['status'] as int,
        message: json['message'] as String,
        page: json['page'] == null ? null : PageResponse.fromJson(json['page']),
        list: null,
        count: json['count'] as int?,
      );
    }
  }

}
