import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

part 'ResponseMeUpdateProfile.g.dart';

@JsonSerializable()
class ResponseMeUpdateProfile {
  final String? imageUrl;

  ResponseMeUpdateProfile({
    required this.imageUrl,
  });

  factory ResponseMeUpdateProfile.fromJson(Map<String, dynamic> json) =>
      _$ResponseMeUpdateProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMeUpdateProfileToJson(this);

  ResponseMeUpdateProfile copyWith({
    String? imageUrl,
  }) {
    return ResponseMeUpdateProfile(
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
