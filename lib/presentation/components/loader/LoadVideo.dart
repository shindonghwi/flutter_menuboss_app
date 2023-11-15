import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:video_player/video_player.dart';

// class LoadVideo extends HookWidget {
//   final String imageUrl;
//   final VideoPlayerController? controller;
//   final BoxFit fit;
//   final bool isHorizontal;
//
//   const LoadVideo({
//     Key? key,
//     this.controller,
//     this.fit = BoxFit.cover,
//     required this.imageUrl,
//     required this.isHorizontal,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final isPlaying = useState(controller?.value.isPlaying ?? false);
//
//     useEffect(() {
//       void listener() {
//         isPlaying.value = controller?.value.isPlaying ?? false;
//       }
//
//       controller?.addListener(listener);
//
//       return () => controller?.removeListener(listener);
//     }, [controller]);
//
//     return controller != null && controller!.value.isInitialized
//         ? LayoutBuilder(builder: (context, constraints) {
//             final aspectRatio = isHorizontal ? 16 / 9 : 9 / 16;
//
//             final maxWidth = constraints.maxWidth;
//             final maxHeight = constraints.maxHeight;
//
//             var renderWidth = 0.0;
//             var renderHeight = 0.0;
//
//             if (fit == BoxFit.contain) {
//               // For BoxFit.contain
//               final containerAspectRatio = maxWidth / maxHeight;
//               if (aspectRatio > containerAspectRatio) {
//                 // Width is limiting factor
//                 renderHeight = maxWidth / aspectRatio;
//               } else {
//                 // Height is limiting factor
//                 renderWidth = maxHeight * aspectRatio;
//               }
//             } else if (fit == BoxFit.cover) {
//               // For BoxFit.cover
//               final containerAspectRatio = maxWidth / maxHeight;
//               if (aspectRatio > containerAspectRatio) {
//                 // Height is limiting factor
//                 renderWidth = maxHeight * aspectRatio;
//               } else {
//                 // Width is limiting factor
//                 renderHeight = maxWidth / aspectRatio;
//               }
//             } else if (fit == BoxFit.fill) {
//               // For BoxFit.fill, use maxWidth and maxHeight as is
//               renderWidth = maxWidth;
//               renderHeight = maxHeight;
//             }
//
//             return SizedBox(
//               width: renderWidth,
//               height: renderHeight,
//               child: VideoPlayer(controller!),
//             );
//           })
//         : LoadImage(
//             url: imageUrl,
//             type: ImagePlaceholderType.AUTO_16x9,
//             fit: fit,
//           );
//   }
// }

class LoadVideo extends HookWidget {
  final VideoPlayerController? controller;
  final BoxFit fit;
  final double rotationDegrees; // Assuming rotation in degrees

  const LoadVideo({
    Key? key,
    required this.controller,
    required this.fit,
    this.rotationDegrees = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller != null && controller!.value.isInitialized
        ? LayoutBuilder(
            builder: (context, constraints) {
              debugPrint("LoadVideo: ${constraints.maxWidth}");
              debugPrint("LoadVideo: ${constraints.maxHeight}");
              final screenW = constraints.maxWidth;
              final screenH = constraints.maxHeight;

              final videoW = controller?.value.size.width ?? 0;
              final videoH = controller?.value.size.height ?? 0;

              // Determine the aspect ratio
              final videoAspectRatio = videoW / videoH;

              double scaleX = 1.0;
              double scaleY = 1.0;

              if (fit == BoxFit.fill) {
                scaleX = screenW / videoW;
                scaleY = screenH / videoH;
              } else if (fit == BoxFit.contain) {
                if (videoAspectRatio > screenW / screenH) {
                  // Fit width
                  scaleX = screenW / videoW;
                  scaleY = scaleX / videoAspectRatio;
                } else {
                  // Fit height
                  scaleY = screenH / videoH;
                  scaleX = scaleY * videoAspectRatio;
                }
              } else if (fit == BoxFit.cover) {
                final aspectRatio = max(screenH / videoH, screenW / videoW);
                scaleX = aspectRatio / (screenW / videoW);
                scaleY = aspectRatio / (screenH / videoH);
              }

              Matrix4 matrix = Matrix4.identity()
                ..scale(scaleX, scaleY)
                ..translate((screenW - videoW) / 2, (screenH - videoH) / 2); // Centering the video

              return Transform(
                transform: matrix,
                alignment: Alignment.center,
                child: SizedBox(
                  width: videoW,
                  height: videoH,
                  child: VideoPlayer(controller!),
                ),
              );
            },
          )
        : Container();
  }
}
