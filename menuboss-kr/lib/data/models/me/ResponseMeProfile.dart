import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

import 'ResponseMePhone.dart';

part 'ResponseMeProfile.g.dart';

@JsonSerializable()
class ResponseMeProfile {
  final String? name;
  final ResponseMePhone? phone;
  final String? imageUrl;

  ResponseMeProfile({
    required this.name,
    required this.phone,
    required this.imageUrl,
  });

  factory ResponseMeProfile.fromJson(Map<String, dynamic> json) => _$ResponseMeProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMeProfileToJson(this);

  ResponseMeProfile copyWith({
    String? name,
    ResponseMePhone? phone,
    String? imageUrl,
  }) {
    return ResponseMeProfile(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
