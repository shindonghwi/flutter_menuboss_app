import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

part 'PageResponse.g.dart';

@JsonSerializable()
class PageResponse {
  final int offsetTime;
  final int size;
  final int totalItems;
  final String q;
  final int currentPage;
  final int totalPages;
  final bool isFirst;
  final bool isLast;
  final bool hasNext;
  final bool hasPrevious;

  PageResponse({
    required this.offsetTime,
    required this.size,
    required this.totalItems,
    required this.q,
    required this.currentPage,
    required this.totalPages,
    required this.isFirst,
    required this.isLast,
    required this.hasNext,
    required this.hasPrevious,
  });

  factory PageResponse.fromJson(Map<String, dynamic> json) => _$PageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PageResponseToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
