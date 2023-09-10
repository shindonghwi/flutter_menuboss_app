class DeviceListModel {
  DeviceListModel(
      this.thumbnail,
      this.screenName,
      this.scheduleName,
      this.updatedAt,
      );

  final String? thumbnail;
  final String screenName;
  final String scheduleName;
  final String updatedAt;

  DeviceListModel copyWith({
    String? thumbnail,
    String? screenName,
    String? scheduleName,
    String? updatedAt,
  }) {
    return DeviceListModel(
      thumbnail ?? this.thumbnail,
      screenName ?? this.screenName,
      scheduleName ?? this.scheduleName,
      updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is DeviceListModel &&
              runtimeType == other.runtimeType &&
              thumbnail == other.thumbnail &&
              screenName == other.screenName &&
              scheduleName == other.scheduleName &&
              updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      thumbnail.hashCode ^
      screenName.hashCode ^
      scheduleName.hashCode ^
      updatedAt.hashCode;
}
