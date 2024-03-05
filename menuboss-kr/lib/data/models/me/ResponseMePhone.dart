import 'package:json_annotation/json_annotation.dart';

part 'ResponseMePhone.g.dart';

@JsonSerializable()
class ResponseMePhone {
  final String? country;
  final String? calling;
  final String? phone;

  ResponseMePhone({
    required this.country,
    required this.calling,
    required this.phone,
  });

  factory ResponseMePhone.fromJson(Map<String, dynamic> json) => _$ResponseMePhoneFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMePhoneToJson(this);

  ResponseMePhone copyWith({
    String? country,
    String? calling,
    String? phone,
  }) {
    return ResponseMePhone(
      country: country ?? this.country,
      calling: calling ?? this.calling,
      phone: phone ?? this.phone,
    );
  }

  @override
  String toString() {
    return '{"country": "$country", "calling": "$calling", "phone": "$phone"}';
  }
}
