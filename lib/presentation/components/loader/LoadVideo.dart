import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';
import 'package:video_player/video_player.dart';

import '../placeholder/ImagePlaceholder.dart';
import 'LoadImage.dart';

class LoadVideo extends HookWidget {
  final String? mediaId;
  final String imageUrl;
  final String? videoUrl;
  final VideoPlayerController? controller;
  final BoxFit fit;
  final bool isHorizontal;

  const LoadVideo({
    Key? key,
    this.mediaId,
    this.controller,
    this.fit = BoxFit.cover,
    required this.imageUrl,
    required this.videoUrl,
    required this.isHorizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isInitialized = useState<bool>(false);
    final controller = useState<VideoPlayerController?>(null);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        debugPrint("LoadVideo3: $controller $videoUrl");
        if (!CollectionUtil.isNullEmptyFromString(videoUrl)) {
          controller.value = VideoPlayerController.networkUrl(Uri.parse(videoUrl.toString()));
          controller.value?.initialize().then((_) async {
            debugPrint("LoadVideo1: $controller");
            controller.value?.setLooping(true);
            controller.value?.play();
            isInitialized.value = controller.value?.value.isInitialized ?? false;
          }).catchError((e) {
            debugPrint("LoadVideo2: $e");
          });
        }
      });
      return null;
    }, [videoUrl]);

    useEffect(() {
      return () {
        Future(() {
          controller.value?.dispose();
        });
      };
    }, []);

    return controller.value != null
        ? LayoutBuilder(
            key: ValueKey(mediaId),
            builder: (context, constraints) {
              final aspectRatio = isHorizontal ? 16 / 9 : 9 / 16;

              final maxWidth = constraints.maxWidth;
              final maxHeight = constraints.maxHeight;

              var renderWidth = 0.0;
              var renderHeight = 0.0;

              if (fit == BoxFit.contain) {
                // For BoxFit.contain
                final containerAspectRatio = maxWidth / maxHeight;
                if (aspectRatio > containerAspectRatio) {
                  // Width is limiting factor
                  renderHeight = maxWidth / aspectRatio;
                } else {
                  // Height is limiting factor
                  renderWidth = maxHeight * aspectRatio;
                }
              } else if (fit == BoxFit.cover) {
                // For BoxFit.cover
                final containerAspectRatio = maxWidth / maxHeight;
                if (aspectRatio > containerAspectRatio) {
                  // Height is limiting factor
                  renderWidth = maxHeight * aspectRatio;
                } else {
                  // Width is limiting factor
                  renderHeight = maxWidth / aspectRatio;
                }
              } else if (fit == BoxFit.fill) {
                // For BoxFit.fill, use maxWidth and maxHeight as is
                renderWidth = maxWidth;
                renderHeight = maxHeight;
              }

              return SizedBox(
                width: renderWidth,
                height: renderHeight,
                child: VideoPlayer(controller.value!),
              );
            },
          )
        : LoadImage(
            tag: mediaId,
            url: imageUrl,
            type: ImagePlaceholderType.AUTO_16x9,
            fit: fit,
          );
  }
}
