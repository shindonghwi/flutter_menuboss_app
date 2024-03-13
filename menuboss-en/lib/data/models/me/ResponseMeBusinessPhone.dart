import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

part 'ResponseMeBusinessPhone.g.dart';

@JsonSerializable()
class ResponseMeBusinessPhone {
  final String? country;
  final String? calling;
  final String? phone;

  ResponseMeBusinessPhone({
    required this.country,
    required this.calling,
    required this.phone,
  });

  factory ResponseMeBusinessPhone.fromJson(Map<String, dynamic> json) => _$ResponseMeBusinessPhoneFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMeBusinessPhoneToJson(this);

  ResponseMeBusinessPhone copyWith({
    String? country,
    String? calling,
    String? phone,
    int? screenId,
    bool? isOnline,
  }) {
    return ResponseMeBusinessPhone(
      country: country ?? this.country,
      calling: calling ?? this.calling,
      phone: phone ?? this.phone,
    );
  }

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
