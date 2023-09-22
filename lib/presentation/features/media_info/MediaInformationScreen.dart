import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/domain/usecases/remote/media/GetMediaUseCase.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleText.dart';
import 'package:menuboss/presentation/components/divider/DividerVertical.dart';
import 'package:menuboss/presentation/components/loader/LoadImage.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/components/textfield/OutlineTextField.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/components/view_state/LoadingView.dart';
import 'package:menuboss/presentation/model/UiState.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/StringUtil.dart';
import 'package:menuboss/presentation/utils/dto/Pair.dart';

import 'provider/MediaNameChangeProvider.dart';

class MediaInformationScreen extends HookConsumerWidget {
  final ResponseMediaModel? item;

  const MediaInformationScreen({
    super.key,
    this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaNameChangeState = ref.watch(MediaNameChangeProvider);
    final mediaNameChangeProvider = ref.read(MediaNameChangeProvider.notifier);
    final fileName = useState<String>(item?.name ?? "");

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          mediaNameChangeState.when(
            success: (event) {
              mediaNameChangeProvider.init();
              Navigator.of(context).pop(fileName.value);
            },
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
        rightIconOnPressed: () => mediaNameChangeProvider.requestChangeMediaName(item!.mediaId, fileName.value),
      ),
      body: SingleChildScrollView(
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
            if (mediaNameChangeState is Loading) const LoadingView(),
          ],
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
                  color: getColorScheme(context).colorGray500,
                ),
          ),
          const SizedBox(height: 12),
          OutlineTextField.small(
            controller: useTextEditingController(text: item?.name),
            hint: item?.name ?? getAppLocalizations(context).media_info_menu_file_name,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _FileImage extends StatelessWidget {
  final ResponseMediaModel? item;

  const _FileImage({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: const EdgeInsets.only(top: 16, left: 24, right: 24),
        decoration: BoxDecoration(
          color: getColorScheme(context).colorGray100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: AspectRatio(
          aspectRatio: 342 / 200,
          child: LoadImage(
            tag: item?.mediaId.toString(),
            url: item?.property?.imageUrl,
            type: ImagePlaceholderType.AUTO_16x9,
          ),
        ),
      ),
    );
  }
}

class _MediaInformation extends HookWidget {
  final ResponseMediaModel? item;

  const _MediaInformation({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final fileName = useState<String?>(null);
    final fileSize = useState<String?>(null);
    final fileCapacity = useState<String?>(null);
    final fileType = useState<String?>(null);
    final fileUploadedDate = useState<String?>(null);

    useEffect(() {
      if (item?.mediaId != null) {
        GetIt.instance<GetMediaUseCase>().call(item!.mediaId).then((response) {
          if (response.status == 200) {
            final data = response.data;

            // file name
            fileName.value = data?.name;

            // file Type
            switch (data?.type?.toLowerCase()) {
              case "image":
                final extension = StringUtil.extractFileExtensionFromUrl(data?.property?.imageUrl);
                fileType.value = "image / $extension";
              case "video":
                final extension = StringUtil.extractFileExtensionFromUrl(data?.property?.videoUrl);
                fileType.value = "video / $extension";
            }

            // file size
            fileSize.value = "${data?.property?.width} X ${data?.property?.height}";

            // file uploaded date
            fileUploadedDate.value = StringUtil.formatSimpleDate(data?.updatedAt.toString() ?? "");

            // file capacity
            fileCapacity.value = StringUtil.formatBytesToMegabytes(data?.property?.size ?? 0);
          } else {
            Toast.showError(context, response.message);
          }
        });
      }
      return null;
    }, []);

    final List<Pair<String, ValueNotifier<String?>>> items = [
      Pair(
        getAppLocalizations(context).media_info_menu_file_name,
        fileName,
      ),
      Pair(
        getAppLocalizations(context).media_info_menu_uploaded_data,
        fileUploadedDate,
      ),
      Pair(
        getAppLocalizations(context).media_info_menu_file_size,
        fileSize,
      ),
      Pair(
        getAppLocalizations(context).media_info_menu_file_type,
        fileType,
      ),
      Pair(
        getAppLocalizations(context).media_info_menu_file_capacity,
        fileCapacity,
      ),
    ];

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
                    color: getColorScheme(context).colorGray500,
                  ),
            ),
          ),
          Column(
            children: items
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e.first,
                          style: getTextTheme(context).b2sb.copyWith(
                                color: getColorScheme(context).colorGray900,
                              ),
                        ),
                        if (e.second.value != null)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 52.0),
                              child: Text(
                                e.second.value.toString(),
                                style: getTextTheme(context).b2m.copyWith(
                                      color: getColorScheme(context).colorGray500,
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
