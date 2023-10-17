import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

import 'ResponseMePhone.dart';

part 'ResponseMeProfile.g.dart';

@JsonSerializable()
class ResponseMeProfile {
  final String? name;
  final ResponseMePhone? phone;

  ResponseMeProfile({
    required this.name,
    required this.phone,
  });

  factory ResponseMeProfile.fromJson(Map<String, dynamic> json) => _$ResponseMeProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMeProfileToJson(this);

  ResponseMeProfile copyWith({
    String? name,
    ResponseMePhone? phone,
  }) {
    return ResponseMeProfile(
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
