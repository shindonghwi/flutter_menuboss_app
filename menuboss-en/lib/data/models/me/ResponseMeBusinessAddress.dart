import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

part 'ResponseMeBusinessAddress.g.dart';

@JsonSerializable()
class ResponseMeBusinessAddress {
  final String? country;
  final String? state;
  final String? city;
  final String? line1;
  final String? line2;
  final String? postalCode;

  ResponseMeBusinessAddress({
    required this.country,
    required this.state,
    required this.city,
    required this.line1,
    required this.line2,
    required this.postalCode,
  });

  factory ResponseMeBusinessAddress.fromJson(Map<String, dynamic> json) =>
      _$ResponseMeBusinessAddressFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMeBusinessAddressToJson(this);

  ResponseMeBusinessAddress copyWith({
    String? country,
    String? state,
    String? city,
    String? line1,
    String? line2,
    String? postalCode,
  }) {
    return ResponseMeBusinessAddress(
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      line1: line1 ?? this.line1,
      line2: line2 ?? this.line2,
      postalCode: postalCode ?? this.postalCode,
    );
  }
  
  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
