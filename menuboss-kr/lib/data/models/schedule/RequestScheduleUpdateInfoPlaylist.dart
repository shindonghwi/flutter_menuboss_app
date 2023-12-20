import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistTime.dart';
import 'package:menuboss_common/utils/StringUtil.dart';

part 'RequestScheduleUpdateInfoPlaylist.g.dart';

@JsonSerializable()
class RequestScheduleUpdateInfoPlaylist {
  final int playlistId;
  final ResponsePlaylistTime? time;

  RequestScheduleUpdateInfoPlaylist({
    required this.playlistId,
    required this.time,
  });

  factory RequestScheduleUpdateInfoPlaylist.fromJson(Map<String, dynamic> json) =>
      _$RequestScheduleUpdateInfoPlaylistFromJson(json);

  RequestScheduleUpdateInfoPlaylist copyWith({
    int? playlistId,
    ResponsePlaylistTime? time,
  }) {
    return RequestScheduleUpdateInfoPlaylist(
      playlistId: playlistId ?? this.playlistId,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toJson() => _$RequestScheduleUpdateInfoPlaylistToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }

}
