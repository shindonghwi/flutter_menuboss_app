import 'package:flutter/material.dart';
import 'package:menuboss/presentation/components/divider/DividerVertical.dart';
import 'package:menuboss/presentation/components/loader/LoadImage.dart';
import 'package:menuboss/presentation/components/placeholder/ImagePlaceholder.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class ScheduleContentItem extends StatelessWidget {
  const ScheduleContentItem({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultItems = [
      "https://w7.pngwing.com/pngs/894/236/png-transparent-sheet-cake-frosting-icing-birthday-cake-chocolate-cake-cake-decorating-wedding-cake-cream-baking-recipe.png"
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              getAppLocalizations(context).common_title,
              style: getTextTheme(context).b3sb.copyWith(
                    color: getColorScheme(context).colorGray500,
                  ),
            ),
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) {
              return const DividerVertical(
                marginVertical: 0,
                height: 1,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              final data = defaultItems[index];
              return SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 140,
                        height: 140,
                        child: LoadImage(
                          url: data,
                          type: ImagePlaceholderType.Large,
                        ),
                      ),
                      // Column(
                      //   children: [
                      //     Text("Basic")
                      //   ],
                      // )
                    ],
                  ),
                ),
              );
            },
            itemCount: defaultItems.length,
          ),
        ],
      ),
    );
  }
}
