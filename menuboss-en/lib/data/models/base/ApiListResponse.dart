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
    try {
      final int status = json!['status'] as int;
      debugPrint('Parsed status: $status');

      final String message = json['message'] as String;
      debugPrint('Parsed message: $message');

      final PageResponse? page = json['page'] == null ? null : PageResponse.fromJson(json['page']);
      debugPrint('Parsed page: $page');

      final T? list = fromJsonT(json['list']);
      debugPrint('Parsed list: $list');

      final int? count = json['count'] as int?;
      debugPrint('Parsed count: $count');

      return ApiListResponse(
        status: status,
        message: message,
        page: page,
        list: list,
        count: count,
      );
    } catch (e) {
      debugPrint('Error at specific parsing point: ${e.toString()}');
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
