import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/presentation/components/appbar/TopBarNoneTitleIcon.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/features/media_content/widget/MediaContentTabVIew.dart';
import 'package:menuboss/presentation/features/media_content/widget/MediaTabCanvas.dart';
import 'package:menuboss/presentation/features/media_content/widget/MediaTabFolder.dart';
import 'package:menuboss/presentation/utils/Common.dart';

import 'widget/MediaTab.dart';

class MediaContentScreen extends HookWidget {
  const MediaContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState<int>(0);
    final isRootLevel = useState<bool>(true);
    final pageController = usePageController(initialPage: currentIndex.value);
    final selectFolderId = useState<String?>(null);

    return BaseScaffold(
      appBar: TopBarNoneTitleIcon(content: getAppLocalizations(context).media_content_title),
      body: Column(
        children: [
          MediaContentTabView(
            onTap: (index) {
              if (index == 0 && !isRootLevel.value) {
                currentIndex.value = 1;
                pageController.jumpToPage(1);
              } else {
                currentIndex.value = index;
                pageController.jumpToPage(index);
              }
            },
            currentIndex: currentIndex.value,
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is UserScrollNotification) {
                  if (currentIndex.value == 1 && notification.direction == ScrollDirection.forward) {
                    return true; // Prevents the scrolling from 1 index to 2 index.
                  }
                }
                return false;
              },
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  if (index == 0) {
                    isRootLevel.value = true;
                  } else if (index == 1) {
                    isRootLevel.value = false;
                  }
                  currentIndex.value = index;
                },
                children: [
                  MediaTab(
                    onFolderTap: (folderId) {
                      selectFolderId.value = folderId;
                      currentIndex.value = 1;
                      pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  MediaTabFolder(
                    folderId: selectFolderId.value ?? "",
                    pageController: pageController,
                    onPressed: () {
                      currentIndex.value = 0;
                      pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  const MediaTabCanvas(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
