// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PageResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageResponse _$PageResponseFromJson(Map<String, dynamic> json) => PageResponse(
      offsetTime: json['offsetTime'] as int,
      size: json['size'] as int,
      totalItems: json['totalItems'] as int,
      q: json['q'] as String,
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
      'q': instance.q,
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'isFirst': instance.isFirst,
      'isLast': instance.isLast,
      'hasNext': instance.hasNext,
      'hasPrevious': instance.hasPrevious,
    };
