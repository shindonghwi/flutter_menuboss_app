import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss_common/components/appbar/TopBarIconTitleText.dart';
import 'package:menuboss_common/components/divider/DividerVertical.dart';
import 'package:menuboss_common/components/loader/LoadImage.dart';
import 'package:menuboss_common/components/loader/LoadVideo.dart';
import 'package:menuboss_common/components/placeholder/PlaceholderType.dart';
import 'package:menuboss_common/components/textfield/OutlineTextField.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/components/view_state/LoadingView.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/Strings.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/CollectionUtil.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/StringUtil.dart';
import 'package:menuboss_common/utils/UiState.dart';
import 'package:menuboss_common/utils/dto/Pair.dart';

import 'provider/MediaInfoProvider.dart';
import 'provider/MediaNameChangeProvider.dart';

class MediaInformationScreen extends HookConsumerWidget {
  final ResponseMediaModel? item;

  const MediaInformationScreen({
    super.key,
    this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaNameChangeState = ref.watch(mediaNameChangeProvider);
    final mediaNameChangeManager = ref.read(mediaNameChangeProvider.notifier);
    final mediaInfoState = ref.watch(mediaInformationProvider);
    final mediaInfoManager = ref.read(mediaInformationProvider.notifier);
    final fileName = useState<String>(item?.name ?? "");

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        mediaInfoManager.requestMediaInformation(item?.mediaId ?? "");
      });
      return () {
        Future(() {
          mediaNameChangeManager.init();
        });
      };
    }, []);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          mediaNameChangeState.when(
            success: (event) => Navigator.of(context).pop(fileName.value),
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [mediaNameChangeState]);

    return BaseScaffold(
      appBar: TopBarIconTitleText(
        content: Strings.of(context).mediaInfoTitle,
        rightText: Strings.of(context).commonSave,
        rightTextActivated: fileName.value.isNotEmpty,
        rightIconOnPressed: () => mediaNameChangeManager.requestChangeMediaName(item!.mediaId, fileName.value),
        onBack: () => popPageWrapper(context: context),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  _InputFileName(
                    item: item,
                    onChanged: (text) => fileName.value = text,
                  ),
                  _FileImage(item: item),
                  const DividerVertical(marginVertical: 16),
                  _MediaInformation(item: item),
                ],
              ),
              if (mediaNameChangeState is Loading || mediaInfoState is Loading) const LoadingView(),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputFileName extends HookWidget {
  final Function(String) onChanged;

  const _InputFileName({
    super.key,
    required this.item,
    required this.onChanged,
  });

  final ResponseMediaModel? item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.of(context).mediaInfoMenuInputTitle,
            style: getTextTheme(context).b3sb.copyWith(
                  color: getColorScheme(context).colorGray700,
                ),
          ),
          const SizedBox(height: 12),
          OutlineTextField.medium(
            controller: useTextEditingController(text: item?.name),
            hint: item?.name ?? Strings.of(context).mediaInfoMenuInputFileNameHint,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _FileImage extends HookConsumerWidget {
  final ResponseMediaModel? item;

  const _FileImage({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaInfoState = ref.watch(mediaInformationProvider);
    final videoUrl = useState<String?>(null);

    useEffect(() {
      void handleUiStateChange() async {
        mediaInfoState.when(
          success: (event) async {
            final data = event.value;

            if (!CollectionUtil.isNullEmptyFromString(data?.property?.videoUrl)) {
              videoUrl.value = data?.property?.videoUrl;
            }
          },
          failure: (event) => Toast.showError(context, event.errorMessage),
        );
      }

      handleUiStateChange();
      return null;
    }, [mediaInfoState]);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: AspectRatio(
        aspectRatio: 342 / 200,
        child: item?.type?.code.toLowerCase() == "video"
            ? ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LoadVideo(
                  mediaId: item?.mediaId,
                  fit: BoxFit.cover,
                  imageUrl: item?.property?.imageUrl ?? "",
                  videoUrl: videoUrl.value,
                  isHorizontal: true,
                ),
              )
            : LoadImage(
                tag: item?.mediaId.toString(),
                url: item?.property?.imageUrl,
                type: ImagePlaceholderType.AUTO_16x9,
              ),
      ),
    );
  }
}

class _MediaInformation extends HookConsumerWidget {
  final ResponseMediaModel? item;

  const _MediaInformation({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaInfoState = ref.watch(mediaInformationProvider);
    final ValueNotifier<List<Pair<String, String>>> mediaItems = useState([]);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          mediaInfoState.when(
            success: (event) {
              final data = event.value;

              final items = <Pair<String, String>>[];

              items.add(
                Pair(
                  Strings.of(context).mediaInfoMenuRegisterDate,
                  data?.updatedAt.toString() ?? "",
                ),
              );

              items.add(
                Pair(
                  Strings.of(context).mediaInfoMenuFileSize,
                  "${data?.property?.width} X ${data?.property?.height}",
                ),
              );

              var isFileTypeImage = true;
              switch (data?.type?.code.toLowerCase()) {
                case "image":
                  final extension = StringUtil.extractFileExtensionFromUrl(data?.property?.imageUrl);
                  items.add(
                    Pair(
                      Strings.of(context).mediaInfoMenuFileType,
                      "image / $extension",
                    ),
                  );
                  break;
                case "video":
                  final extension = StringUtil.extractFileExtensionFromUrl(data?.property?.videoUrl);
                  items.add(
                    Pair(
                      Strings.of(context).mediaInfoMenuFileType,
                      "video / $extension",
                    ),
                  );
                  isFileTypeImage = false;
                  break;
              }

              items.add(
                Pair(
                  Strings.of(context).mediaInfoMenuFileCapacity,
                  StringUtil.formatBytesToMegabytes(data?.property?.size ?? 0),
                ),
              );

              if (!CollectionUtil.isNullEmptyFromString(data?.property?.codec)) {
                items.add(
                  Pair(
                    Strings.of(context).mediaInfoMenuFileCodec,
                    data?.property?.codec?.toString() ?? "",
                  ),
                );
              }

              if (!CollectionUtil.isNullEmptyFromString(data?.property?.duration.toString()) && !isFileTypeImage) {
                items.add(
                  Pair(
                    Strings.of(context).mediaInfoMenuFileRunningTime,
                    StringUtil.formatDuration(data?.property?.duration ?? 0),
                  ),
                );
              }

              mediaItems.value = [...items];
            },
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [mediaInfoState]);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              Strings.of(context).mediaInfoMenuTitle,
              style: getTextTheme(context).b3sb.copyWith(
                    color: getColorScheme(context).colorGray700,
                  ),
            ),
          ),
          Column(
            children: mediaItems.value
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (!CollectionUtil.isNullEmptyFromString(e.second))
                          Text(
                            e.first,
                            style: getTextTheme(context).b3m.copyWith(
                                  color: getColorScheme(context).colorGray900,
                                ),
                          ),
                        if (!CollectionUtil.isNullEmptyFromString(e.second))
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 52.0),
                              child: Text(
                                e.second.toString(),
                                style: getTextTheme(context).b3r.copyWith(
                                      color: getColorScheme(context).colorGray600,
                                    ),
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
