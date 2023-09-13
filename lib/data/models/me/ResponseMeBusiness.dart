import 'package:json_annotation/json_annotation.dart';

part 'ResponseMeBusiness.g.dart';

@JsonSerializable()
class ResponseMeBusiness {
  final String? title;
  final String? role;
  final List<String>? permissions;

  ResponseMeBusiness({
    required this.title,
    required this.role,
    required this.permissions,
  });

  factory ResponseMeBusiness.fromJson(Map<String, dynamic> json) => _$ResponseMeBusinessFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMeBusinessToJson(this);

  ResponseMeBusiness copyWith({
    String? title,
    String? role,
    List<String>? permissions,
  }) {
    return ResponseMeBusiness(
      title: title ?? this.title,
      role: role ?? this.role,
      permissions: permissions ?? this.permissions,
    );
  }

  @override
  String toString() {
    return '{"title": "$title", "role": "$role", "permissions": "$permissions"}';
  }
}
