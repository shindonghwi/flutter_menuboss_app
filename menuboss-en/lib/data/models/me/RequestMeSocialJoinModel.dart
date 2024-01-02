import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

part 'RequestMeSocialJoinModel.g.dart';

@JsonSerializable()
class RequestMeSocialJoinModel {
  final String type;
  final String accessToken;
  final String? name;
  final String? business;
  final String? timeZone;

  RequestMeSocialJoinModel({
    required this.type,
    required this.accessToken,
    this.name,
    this.business,
    this.timeZone,
  });

  factory RequestMeSocialJoinModel.fromJson(Map<String, dynamic> json) => _$RequestMeSocialJoinModelFromJson(json);

  RequestMeSocialJoinModel copyWith({
    String? type,
    String? accessToken,
    String? name,
    String? business,
    String? timeZone,
  }) {
    return RequestMeSocialJoinModel(
      type: type ?? this.type,
      accessToken: accessToken ?? this.accessToken,
      name: name ?? this.name,
      business: business ?? this.business,
      timeZone: timeZone ?? this.timeZone,
    );
  }

  Map<String, dynamic> toJson() => _$RequestMeSocialJoinModelToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
