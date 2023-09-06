import 'package:image_picker/image_picker.dart';

abstract class FilePickerListener {
  void onSelectedImage(XFile file);

  void onSelectedVideo(XFile file);

  void notAvailableFile();
}

class FilePickerUtil {
  static final _picker = ImagePicker();
  static final allowedExtensionsImage = ['jpg', 'jpeg', 'png', 'gif'];
  static final allowedExtensionsVideo = ['mp4', 'avi', 'mov', 'flv'];

  /// @feature: 파일을 선택하는 기능 ( 이미지, 비디오 )
  /// @author: 2023/09/06 11:56 AM donghwishin
  static void pickFile(FilePickerListener listener) async {
    XFile? xFile = await _picker.pickImage(source: ImageSource.gallery);

    final String? extension = xFile?.path.split('.').last;

    if (xFile != null){
      if (allowedExtensionsImage.contains(extension?.toLowerCase())) {
        listener.onSelectedImage(xFile);
        return;
      } else if (allowedExtensionsVideo.contains(extension?.toLowerCase())) {
        listener.onSelectedVideo(xFile);
        return;
      }
    }
    listener.notAvailableFile();
  }
}
