import 'package:json_annotation/json_annotation.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';

part 'RequestDeviceApplyContents.g.dart';

@JsonSerializable()
class RequestDeviceApplyContents {
  final List<int> screenIds;
  final String contentType;
  final int contentId;

  RequestDeviceApplyContents({
    this.screenIds = const [],
    required this.contentType,
    required this.contentId,
  });

  factory RequestDeviceApplyContents.fromJson(Map<String, dynamic> json) => _$RequestDeviceApplyContentsFromJson(json);

  RequestDeviceApplyContents copyWith({
    List<int>? screenIds,
    String? contentType,
    int? contentId,
  }) {
    return RequestDeviceApplyContents(
      screenIds: screenIds ?? this.screenIds,
      contentType: contentType ?? this.contentType,
      contentId: contentId ?? this.contentId,
    );
  }

  Map<String, dynamic> toJson() => _$RequestDeviceApplyContentsToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
