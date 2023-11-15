import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleText.dart';
import 'package:menuboss/presentation/components/divider/DividerVertical.dart';
import 'package:menuboss/presentation/components/loader/LoadImage.dart';
import 'package:menuboss/presentation/components/loader/LoadVideo.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/components/textfield/OutlineTextField.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/components/view_state/LoadingView.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';
import 'package:menuboss/presentation/utils/dto/Pair.dart';
import 'package:video_player/video_player.dart';

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
        content: getAppLocalizations(context).media_info_title,
        rightText: getAppLocalizations(context).common_save,
        rightTextActivated: fileName.value.isNotEmpty,
        rightIconOnPressed: () => mediaNameChangeManager.requestChangeMediaName(item!.mediaId, fileName.value),
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
            getAppLocalizations(context).media_info_menu_input_title,
            style: getTextTheme(context).b3b.copyWith(
                  color: getColorScheme(context).colorGray900,
                ),
          ),
          const SizedBox(height: 12),
          OutlineTextField.small(
            controller: useTextEditingController(text: item?.name),
            hint: item?.name ?? getAppLocalizations(context).media_info_menu_input_file_name_hint,
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
      margin: const EdgeInsets.only(top: 16, left: 24, right: 24),
      decoration: BoxDecoration(
        color: getColorScheme(context).colorGray100,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          width: 1,
          color: getColorScheme(context).colorGray200,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: AspectRatio(
          aspectRatio: 342 / 200,
          child: item?.type?.code.toLowerCase() == "video"
              ? LoadVideo(
                  mediaId: item?.mediaId,
                  fit: BoxFit.cover,
                  imageUrl: item?.property?.imageUrl ?? "",
                  videoUrl: videoUrl.value,
                  isHorizontal: true
                )
              : LoadImage(
                  tag: item?.mediaId.toString(),
                  url: item?.property?.imageUrl,
                  type: ImagePlaceholderType.AUTO_16x9,
                ),
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
                  getAppLocalizations(context).media_info_menu_modified_data,
                  data?.updatedAt.toString() ?? "",
                ),
              );

              items.add(
                Pair(
                  getAppLocalizations(context).media_info_menu_file_size,
                  "${data?.property?.width} X ${data?.property?.height}",
                ),
              );

              var isFileTypeImage = true;
              switch (data?.type?.code.toLowerCase()) {
                case "image":
                  final extension = StringUtil.extractFileExtensionFromUrl(data?.property?.imageUrl);
                  items.add(
                    Pair(
                      getAppLocalizations(context).media_info_menu_file_type,
                      "image / $extension",
                    ),
                  );
                case "video":
                  final extension = StringUtil.extractFileExtensionFromUrl(data?.property?.videoUrl);
                  items.add(
                    Pair(
                      getAppLocalizations(context).media_info_menu_file_type,
                      "video / $extension",
                    ),
                  );
                  isFileTypeImage = false;
              }

              items.add(
                Pair(
                  getAppLocalizations(context).media_info_menu_file_capacity,
                  StringUtil.formatBytesToMegabytes(data?.property?.size ?? 0),
                ),
              );

              if (!CollectionUtil.isNullEmptyFromString(data?.property?.codec)) {
                items.add(
                  Pair(
                    getAppLocalizations(context).media_info_menu_file_codec,
                    data?.property?.codec?.toString() ?? "",
                  ),
                );
              }

              if (!CollectionUtil.isNullEmptyFromString(data?.property?.duration.toString()) && !isFileTypeImage) {
                items.add(
                  Pair(
                    getAppLocalizations(context).media_info_menu_file_running_time,
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
              getAppLocalizations(context).media_info_title,
              style: getTextTheme(context).b3b.copyWith(
                    color: getColorScheme(context).colorGray900,
                  ),
            ),
          ),
          Column(
            children: mediaItems.value
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (!CollectionUtil.isNullEmptyFromString(e.second))
                          Text(
                            e.first,
                            style: getTextTheme(context).b3sb.copyWith(
                                  color: getColorScheme(context).colorGray900,
                                ),
                          ),
                        if (!CollectionUtil.isNullEmptyFromString(e.second))
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 52.0),
                              child: Text(
                                e.second.toString(),
                                style: getTextTheme(context).b3m.copyWith(
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
