import 'package:flutter/material.dart';
import 'package:menuboss/presentation/components/appbar/TopBarIconTitleNone.dart';
import 'package:menuboss/presentation/components/divider/DividerVertical.dart';
import 'package:menuboss/presentation/components/loader/LoadImage.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/dto/Pair.dart';

class MediaInformationScreen extends StatelessWidget {
  const MediaInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: TopBarIconTitleNone(
        content: getAppLocalizations(context).media_info_title,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _FileImage(
              imagePath: "https://blog.kakaocdn.net/dn/cxrMOV/btqCqOwWxYV/ltWjZ6UdKCPtbch4lsDbW1/img.jpg",
            ),
            DividerVertical(marginVertical: 12),
            _MediaInformation(),
          ],
        ),
      ),
    );
  }
}

class _FileImage extends StatelessWidget {
  final String? imagePath;

  const _FileImage({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 342 / 200,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: getColorScheme(context).colorGray100,
            ),
            child: LoadImage(
              url: imagePath!,
              type: ImagePlaceholderType.AUTO_16x9,
            ),
          ),
        ),
      ),
    );
  }
}

class _MediaInformation extends StatelessWidget {
  const _MediaInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      Pair(
        getAppLocalizations(context).media_info_menu_uploaded_data,
        "Aug 24th, 2023",
      ),
      Pair(
        getAppLocalizations(context).media_info_menu_file_size,
        "320 X 280",
      ),
      Pair(
        getAppLocalizations(context).media_info_menu_file_type,
        "image / png",
      ),
      Pair(
        getAppLocalizations(context).media_info_menu_file_capacity,
        "320KB",
      ),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              getAppLocalizations(context).media_info_menu,
              style: getTextTheme(context).c1sb.copyWith(
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
                        Text(
                          e.second,
                          style: getTextTheme(context).b2m.copyWith(
                                color: getColorScheme(context).colorGray500,
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
