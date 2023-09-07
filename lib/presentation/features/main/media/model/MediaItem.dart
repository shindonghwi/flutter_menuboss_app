import 'MediaType.dart';

class MediaItem {
  MediaItem(this.type, this.fileName, this.folderCount, this.size);

  final MediaType type;
  final int folderCount;
  final String size;
  final String fileName;
}