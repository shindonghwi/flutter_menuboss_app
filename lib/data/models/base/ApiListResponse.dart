import 'package:flutter/cupertino.dart';
import 'package:menuboss/data/models/base/PageResponse.dart';

class ApiListResponse<T> {
  final int status;
  final String message;
  final PageResponse? page;
  final T? list;
  final int count;

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
    try {
      return ApiListResponse(
        status: json!['status'] as int,
        message: json['message'] as String,
        page: json['page'] as PageResponse?,
        list: fromJsonT(json['list']),
        count: json['count'] as int,
      );
    } catch (e) {
      debugPrint('Error parsing JSON: $e');
      return ApiListResponse(
        status: json!['status'] as int,
        message: json['message'] as String,
        page: json['page'] as PageResponse?,
        list: null,
        count: json['count'] as int,
      );
    }
  }

}
