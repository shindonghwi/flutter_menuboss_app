// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PageResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageResponse _$PageResponseFromJson(Map<String, dynamic> json) => PageResponse(
      q: json['q'] as String?,
      sort: json['sort'] as String? ?? "created_asc",
      offsetTime: json['offsetTime'] as int,
      size: json['size'] as int,
      totalItems: json['totalItems'] as int,
      mediaId: json['mediaId'] as String?,
      currentPage: json['currentPage'] as int,
      totalPages: json['totalPages'] as int,
      isFirst: json['isFirst'] as bool,
      isLast: json['isLast'] as bool,
      hasNext: json['hasNext'] as bool,
      hasPrevious: json['hasPrevious'] as bool,
    );

Map<String, dynamic> _$PageResponseToJson(PageResponse instance) =>
    <String, dynamic>{
      'offsetTime': instance.offsetTime,
      'size': instance.size,
      'totalItems': instance.totalItems,
      'mediaId': instance.mediaId,
      'totalPages': instance.totalPages,
      'currentPage': instance.currentPage,
      'q': instance.q,
      'sort': instance.sort,
      'isFirst': instance.isFirst,
      'isLast': instance.isLast,
      'hasNext': instance.hasNext,
      'hasPrevious': instance.hasPrevious,
    };
