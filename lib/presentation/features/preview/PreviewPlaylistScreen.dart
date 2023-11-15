import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/presentation/components/appbar/TopBarNoneTitleIcon.dart';
import 'package:menuboss/presentation/components/loader/LoadImage.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/components/utils/Clickable.dart';
import 'package:menuboss/presentation/features/create/playlist/provider/PlaylistSaveInfoProvider.dart';
import 'package:menuboss/presentation/features/preview/provider/PreviewListProvider.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:video_player/video_player.dart';

import '../create/playlist/provider/CreatePreviewItemProcessProvider.dart';
import '../detail/playlist/provider/DetailPreviewItemProcessProvider.dart';

class PreviewPlaylistScreen extends HookConsumerWidget {
  const PreviewPlaylistScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final previewState = ref.watch(previewListProvider);

    final createPreviewProcessManager = ref.read(createPreviewItemProcessProvider.notifier);
    final detailPreviewProcessManager = ref.read(detailPreviewItemProcessProvider.notifier);

    final currentPage = useState(0);

    final directionType = useState(previewState?.direction);
    final contentScale = useState(previewState?.fill);

    List<int?> durations = previewState?.durations ?? [];

    final videoControllers = useState<List<VideoPlayerController?>?>(null);

    useEffect(() {
      return (){
        Future((){
          createPreviewProcessManager.init();
          detailPreviewProcessManager.init();
        });
      };
    },[]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        videoControllers.value = previewState?.previewItems.map((mediaContent) {
          if (mediaContent.type?.toLowerCase() == "video") {
            var controller = VideoPlayerController.networkUrl(Uri.parse(mediaContent.property!.videoUrl ?? ""))
              ..initialize().then((_) {
                debugPrint("video initialized");
              }).catchError((e) {
                debugPrint(e.toString());
              });
            controller.setLooping(true);
            return controller;
          }
          return null;
        }).toList();
      });
      return () => videoControllers.value?.forEach((controller) => controller?.dispose());
    }, [previewState]);

    return BaseScaffold(
      appBar: TopBarNoneTitleIcon(
        content: getAppLocalizations(context).common_preview,
        backgroundColor: Colors.transparent,
        reverseContentColor: true,
      ),
      backgroundColor: getColorScheme(context).black,
      body: Column(
        children: [
          _Settings(
            directionType: directionType,
            contentScale: contentScale,
          ),
          _Display(
            currentPage: currentPage,
            videoControllers: videoControllers.value,
            durations: durations.map((e) => e ?? -1).toList(),
            directionType: directionType.value,
            contentScale: contentScale.value,
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: TimerDivider(
            durations: durations,
            currentPageNotifier: currentPage,
            onStart: () {
              videoControllers.value?[currentPage.value]?.play();
            },
            onStop: () {
              videoControllers.value?[currentPage.value]?.pause();
            }),
      ),
    );
  }
}

class _Display extends HookConsumerWidget {
  final ValueNotifier<int> currentPage;
  final List<VideoPlayerController?>? videoControllers;
  final List<int> durations;
  final PlaylistSettingType? directionType;
  final PlaylistSettingType? contentScale;

  const _Display({
    super.key,
    required this.currentPage,
    required this.videoControllers,
    required this.durations,
    required this.directionType,
    required this.contentScale,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final previewState = ref.watch(previewListProvider);

    final ratio = directionType == PlaylistSettingType.Horizontal ? 16 / 9 : 9 / 16;
    var fitInfo = BoxFit.contain;

    if (contentScale == PlaylistSettingType.Fit) {
      fitInfo = BoxFit.contain;
    } else if (contentScale == PlaylistSettingType.Fill) {
      fitInfo = BoxFit.cover;
    } else if (contentScale == PlaylistSettingType.Stretch) {
      fitInfo = BoxFit.fill;
    }

    // duration에 따라 표시되는 로직을 추가하기 위해 사용될 State
    final autoAdvanceTimer = useState<Timer?>(null);

    useEffect(() {
      autoAdvanceTimer.value?.cancel(); // 이전 타이머가 있다면 취소
      if (durations.isNotEmpty && currentPage.value < durations.length) {
        autoAdvanceTimer.value = Timer(Duration(seconds: durations[currentPage.value]), () {
          currentPage.value = (currentPage.value + 1) % durations.length;
        });
      }
      return () => autoAdvanceTimer.value?.cancel(); // 정리 함수
    }, [currentPage, durations]); // currentPage와 durations 변경시 재실행

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60.0),
        child: Stack(
          alignment: Alignment.center,
          children: previewState?.previewItems.map((mediaContent) {
                int index = previewState.previewItems.indexOf(mediaContent);
                bool isCurrentPage = currentPage.value == index;

                return AnimatedOpacity(
                  key: Key("${mediaContent.id}-$index}"),
                  opacity: isCurrentPage ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: getColorScheme(context).colorGray800,
                        width: 4,
                      ),
                    ),
                    child: AspectRatio(
                      key: Key("${mediaContent.id}-$index"),
                      aspectRatio: ratio,
                      child: LoadImage(
                        tag: "${mediaContent.id}-$index",
                        url: mediaContent.property?.imageUrl,
                        type: ImagePlaceholderType.AUTO_16x9,
                        fit: fitInfo,
                      ),
                    ),
                  ),
                );
              }).toList() ??
              [],
        ),
      ),
    );
  }
}

class _Settings extends HookWidget {
  final ValueNotifier<PlaylistSettingType?> directionType;
  final ValueNotifier<PlaylistSettingType?> contentScale;

  const _Settings({
    super.key,
    required this.directionType,
    required this.contentScale,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 66,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _PreviewSettingIcon(
                    iconPath: 'assets/imgs/icon_horizontal_line.svg',
                    content: getAppLocalizations(context).common_horizontal,
                    isSelected: directionType.value == PlaylistSettingType.Horizontal,
                    onPressed: () => directionType.value = PlaylistSettingType.Horizontal,
                  ),
                  _PreviewSettingIcon(
                    iconPath: 'assets/imgs/icon_vertical_line.svg',
                    content: getAppLocalizations(context).common_vertical,
                    isSelected: directionType.value == PlaylistSettingType.Vertical,
                    onPressed: () => directionType.value = PlaylistSettingType.Vertical,
                  )
                ],
              ),
            ),
            Container(
              width: 1,
              height: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              color: getColorScheme(context).white,
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Row(
                children: [
                  _PreviewSettingIcon(
                    iconPath: 'assets/imgs/icon_fill_filled.svg',
                    content: getAppLocalizations(context).common_fill,
                    isSelected: contentScale.value == PlaylistSettingType.Fill,
                    onPressed: () => contentScale.value = PlaylistSettingType.Fill,
                  ),
                  _PreviewSettingIcon(
                    iconPath: 'assets/imgs/icon_fit.svg',
                    content: getAppLocalizations(context).common_fit,
                    isSelected: contentScale.value == PlaylistSettingType.Fit,
                    onPressed: () => contentScale.value = PlaylistSettingType.Fit,
                  ),
                  _PreviewSettingIcon(
                    iconPath: 'assets/imgs/icon_stretch.svg',
                    content: getAppLocalizations(context).common_stretch,
                    isSelected: contentScale.value == PlaylistSettingType.Stretch,
                    onPressed: () => contentScale.value = PlaylistSettingType.Stretch,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _PreviewSettingIcon extends StatelessWidget {
  final String iconPath;
  final String content;
  final bool isSelected;
  final VoidCallback onPressed;

  const _PreviewSettingIcon({
    super.key,
    required this.iconPath,
    required this.content,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Clickable(
        onPressed: () => onPressed.call(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                isSelected ? getColorScheme(context).white : getColorScheme(context).colorGray500,
                BlendMode.srcIn,
              ),
            ),
            Text(
              content,
              style: getTextTheme(context).c1sb.copyWith(
                    color: isSelected ? getColorScheme(context).white : getColorScheme(context).colorGray500,
                  ),
            )
          ],
        ),
      ),
    );
  }
}

class TimerDivider extends HookWidget {
  final List<int?> durations;
  final ValueNotifier<int> currentPageNotifier;
  final VoidCallback onStart;
  final VoidCallback onStop;

  const TimerDivider({
    super.key,
    required this.durations,
    required this.currentPageNotifier,
    required this.onStart,
    required this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    final progressValue = useState(0.0);
    final timer = useState<Timer?>(null);

    useEffect(() {
      return () {
        timer.value?.cancel();
      };
    }, const []);

    void startTimer() {
      timer.value?.cancel(); // 이전 타이머가 있다면 취소
      timer.value = Timer.periodic(const Duration(seconds: 1), (timer) {
        progressValue.value += 1 / durations[currentPageNotifier.value]!;
        if (progressValue.value >= 1) {
          timer.cancel();
          if (currentPageNotifier.value < durations.length - 1) {
            currentPageNotifier.value++;
          } else {
            currentPageNotifier.value = 0;
          }
          progressValue.value = 0;
          startTimer();
        }
      });
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: List.generate(
              durations.length,
              (index) => Expanded(
                child: Clickable(
                  onPressed: () {
                    if (currentPageNotifier.value == index) return;
                    currentPageNotifier.value = index;
                    progressValue.value = 0;
                    timer.value?.cancel();
                    startTimer();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 4,
                          decoration: BoxDecoration(
                            color: getColorScheme(context).white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        if (currentPageNotifier.value == index)
                          Container(
                            width: max(
                              0,
                              MediaQuery.of(context).size.width / durations.length * progressValue.value,
                            ),
                            height: 4,
                            decoration: BoxDecoration(
                              color: getColorScheme(context).white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Clickable(
                  onPressed: () {
                    if (currentPageNotifier.value == 0) return;
                    currentPageNotifier.value--;
                    progressValue.value = 0;
                    timer.value?.cancel();
                    startTimer();
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        "assets/imgs/icon_skip_back.svg",
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          getColorScheme(context).white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Clickable(
                  onPressed: () {
                    if (timer.value != null) {
                      timer.value?.cancel();
                      timer.value = null;
                      onStop.call();
                    } else {
                      startTimer();
                      onStart.call();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      timer.value == null ? "assets/imgs/icon_play.svg" : "assets/imgs/icon_pause.svg",
                      width: 40,
                      height: 40,
                      colorFilter: ColorFilter.mode(
                        getColorScheme(context).white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Clickable(
                  onPressed: () {
                    if (currentPageNotifier.value == durations.length - 1) return;
                    currentPageNotifier.value++;
                    progressValue.value = 0;
                    timer.value?.cancel();
                    startTimer();
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        "assets/imgs/icon_skip_fwd.svg",
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          getColorScheme(context).white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
