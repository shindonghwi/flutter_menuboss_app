import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

part 'ResponseMeAuthorization.g.dart';

@JsonSerializable()
class ResponseMeAuthorization {
  final String? accessToken;

  ResponseMeAuthorization({
    required this.accessToken,
  });

  factory ResponseMeAuthorization.fromJson(Map<String, dynamic> json) => _$ResponseMeAuthorizationFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMeAuthorizationToJson(this);

  ResponseMeAuthorization copyWith({
    String? accessToken,
  }) {
    return ResponseMeAuthorization(
      accessToken: accessToken ?? this.accessToken,
    );
  }

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
