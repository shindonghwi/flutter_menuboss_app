import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class FilePickerUtil {
  static final _picker = ImagePicker();
  static final allowedExtensionsImage = ['jpg', 'jpeg', 'png'];
  static final allowedExtensionsVideo = ['mp4', 'avi', 'mov', 'flv'];

  /// @feature: 파일을 선택하는 기능 ( 이미지, 비디오 )
  /// @author: 2023/09/06 11:56 AM donghwishin
  static void pickFile({
    required Function(XFile)? onImageSelected,
    required Function(XFile)? onVideoSelected,
    required Function()? notAvailableFile,
  }) async {
    try {
      XFile? xFile = await _picker.pickImage(source: ImageSource.gallery);

      final String? extension = xFile?.path.split('.').last;

      if (xFile != null) {
        if (allowedExtensionsImage.contains(extension?.toLowerCase())) {
          if (onImageSelected != null) onImageSelected(xFile);
          return;
        } else if (allowedExtensionsVideo.contains(extension?.toLowerCase())) {
          if (onVideoSelected != null) onVideoSelected(xFile);
          return;
        }
      }
      if (notAvailableFile != null && xFile != null) notAvailableFile();
    } catch (e) {
      // Handle the exception, log it, or provide an error message as needed.
      debugPrint('Error in pickFile: $e');
      if (notAvailableFile != null) notAvailableFile();
    }
  }
}
