import 'MediaType.dart';

class MediaModel {
  MediaModel(this.type, this.fileName, this.folderCount, this.size);

  final MediaType type;
  final int folderCount;
  final String size;
  final String fileName;
}