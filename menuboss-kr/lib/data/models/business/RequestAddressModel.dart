import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

part 'RequestAddressModel.g.dart';

@JsonSerializable()
class RequestAddressModel {
  final String country;
  final String line1;
  final String line2;
  final String phone;
  final String postalCode;

  RequestAddressModel({
    required this.country,
    required this.line1,
    this.line2 = "",
    required this.phone,
    required this.postalCode ,
  });

  factory RequestAddressModel.fromJson(Map<String, dynamic> json) =>
      _$RequestAddressModelFromJson(json);

  RequestAddressModel copyWith({
    String? country,
    String? line1,
    String? line2,
    String? phone,
    String? postalCode,
  }) {
    return RequestAddressModel(
      country: country ?? this.country,
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
