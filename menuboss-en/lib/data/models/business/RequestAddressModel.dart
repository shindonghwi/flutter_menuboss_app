import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

part 'RequestAddressModel.g.dart';

@JsonSerializable()
class RequestAddressModel {
  final String country;
  final String city;
  final String line1;
  final String postalCode;
  final String phone;
  final String line2;
  final String state;

  RequestAddressModel({
    required this.country,
    required this.city,
    required this.line1,
    required this.postalCode,
    required this.phone,
    this.state = "",
    this.line2 = "",
  });

  factory RequestAddressModel.fromJson(Map<String, dynamic> json) =>
      _$RequestAddressModelFromJson(json);

  RequestAddressModel copyWith({
    String? country,
    String? state,
    String? city,
    String? line1,
    String? line2,
    String? phone,
    String? postalCode,
  }) {
    return RequestAddressModel(
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      line1: line1 ?? this.line1,
      line2: line2 ?? this.line2,
      phone: phone ?? this.phone,
      postalCode: postalCode ?? this.postalCode,
    );
  }

  Map<String, dynamic> toJson() => _$RequestAddressModelToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
