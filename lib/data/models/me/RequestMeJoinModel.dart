import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

part 'RequestMeJoinModel.g.dart';

@JsonSerializable()
class RequestMeJoinModel {
  final String email;
  final String name;
  final String password;
  final String business;
  final String timeZone;

  RequestMeJoinModel({
    required this.email,
    required this.name,
    required this.password,
    required this.business,
    required this.timeZone,
  });

  factory RequestMeJoinModel.fromJson(Map<String, dynamic> json) => _$RequestMeJoinModelFromJson(json);

  RequestMeJoinModel copyWith({
    String? email,
    String? name,
    String? password,
    String? business,
    String? timeZone,
  }) {
    return RequestMeJoinModel(
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      business: business ?? this.business,
      timeZone: timeZone ?? this.timeZone,
    );
  }

  Map<String, dynamic> toJson() => _$RequestMeJoinModelToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
