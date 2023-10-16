import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

part 'RequestPlaylistUpdateInfoContents.g.dart';

@JsonSerializable()
class RequestPlaylistUpdateInfoContents {
  final String contentId;
  final double? duration;

  RequestPlaylistUpdateInfoContents({
    required this.contentId,
    required this.duration,
  });

  factory RequestPlaylistUpdateInfoContents.fromJson(Map<String, dynamic> json) =>
      _$RequestPlaylistUpdateInfoContentsFromJson(json);

  RequestPlaylistUpdateInfoContents copyWith({
    String? contentId,
    double? duration,
  }) {
    return RequestPlaylistUpdateInfoContents(
      contentId: contentId ?? this.contentId,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toJson() => _$RequestPlaylistUpdateInfoContentsToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
