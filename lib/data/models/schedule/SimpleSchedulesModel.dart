import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

part 'SimpleSchedulesModel.g.dart';

@JsonSerializable()
class SimpleSchedulesModel {
  final bool isRequired;
  final bool isAddButton;
  final String imageUrl;
  final int? playlistId;
  final String playListName;
  final String? start;
  final String? end;
  final bool timeIsDuplicate;

  SimpleSchedulesModel({
    required this.isRequired,
    required this.isAddButton,
    required this.imageUrl,
    required this.playlistId,
    required this.playListName,
    required this.start,
    required this.end,
    required this.timeIsDuplicate,
  });

  factory SimpleSchedulesModel.fromJson(Map<String, dynamic> json) => _$SimpleSchedulesModelFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleSchedulesModelToJson(this);

  SimpleSchedulesModel copyWith({
    bool? isRequired,
    bool? isAddButton,
    String? imageUrl,
    int? playlistId,
    String? playListName,
    String? start,
    String? end,
    bool? timeIsDuplicate,
  }) {
    return SimpleSchedulesModel(
      isRequired: isRequired ?? this.isRequired,
      isAddButton: isAddButton ?? this.isAddButton,
      imageUrl: imageUrl ?? this.imageUrl,
      playlistId: playlistId ?? this.playlistId,
      playListName: playListName ?? this.playListName,
      start: start ?? this.start,
      end: end ?? this.end,
      timeIsDuplicate: timeIsDuplicate ?? this.timeIsDuplicate,
    );
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SimpleSchedulesModel &&
        other.isRequired == isRequired &&
        other.isAddButton == isAddButton &&
        other.imageUrl == imageUrl &&
        other.playlistId == playlistId &&
        other.playListName == playListName &&
        other.start == start &&
        other.end == end&&
        other.timeIsDuplicate == timeIsDuplicate;
  }

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
