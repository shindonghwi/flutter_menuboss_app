import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

part 'ResponseBusinessMemberPhone.g.dart';

@JsonSerializable()
class ResponseBusinessMemberPhone {
  final String? country;
  final String? calling;
  final String? phone;

  ResponseBusinessMemberPhone({
    required this.country,
    required this.calling,
    required this.phone,
  });

  factory ResponseBusinessMemberPhone.fromJson(Map<String, dynamic> json) => _$ResponseBusinessMemberPhoneFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseBusinessMemberPhoneToJson(this);

  ResponseBusinessMemberPhone copyWith({
    String? country,
    String? calling,
    String? phone,
    int? screenId,
    bool? isOnline,
  }) {
    return ResponseBusinessMemberPhone(
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
