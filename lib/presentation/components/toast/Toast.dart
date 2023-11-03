import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/CollectionUtil.dart';
import 'package:menuboss/presentation/utils/Common.dart';

enum ToastType { Success, Error, Warning }

class Toast {
  static OverlayEntry? _overlayEntry;
  static Timer? _timer;

  static showError(
    BuildContext context,
    String message, {
    Duration autoCloseTime = const Duration(seconds: 5),
  }) {
    if (CollectionUtil.isNullEmptyFromString(message)) return;
    _removeExistingToast();
    _addOverlayEntry(context, ToastType.Error, message);
    _cancelTimer(autoCloseTime);
  }

  static showSuccess(
    BuildContext context,
    String message, {
    Duration autoCloseTime = const Duration(seconds: 5),
  }) {
    if (CollectionUtil.isNullEmptyFromString(message)) return;
    _removeExistingToast();
    _addOverlayEntry(context, ToastType.Success, message);
    _cancelTimer(autoCloseTime);
  }

  static showWarning(
    BuildContext context,
    String message, {
    Duration autoCloseTime = const Duration(seconds: 5),
  }) {
    if (CollectionUtil.isNullEmptyFromString(message)) return;
    _removeExistingToast();
    _addOverlayEntry(context, ToastType.Warning, message);
    _cancelTimer(autoCloseTime);
  }

  static void _addOverlayEntry(BuildContext context, ToastType type, String message) {
    final overlay = Overlay.of(context, rootOverlay: true);
    _overlayEntry = OverlayEntry(
      builder: (context) => _ToastWidget(message: message, onDismissed: _removeExistingToast, type: type),
    );
    overlay.insert(_overlayEntry!);
  }

  static void _cancelTimer(Duration autoCloseTime) {
    _timer?.cancel(); // 이전 Timer가 있으면 취소
    _timer = Timer(autoCloseTime, () {
      _removeExistingToast();
    });
  }

  static _removeExistingToast() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class _ToastWidget extends HookWidget {
  final String message;
  final VoidCallback onDismissed;
  final ToastType type;

  const _ToastWidget({
    required this.message,
    required this.onDismissed,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(duration: const Duration(milliseconds: 500));
    final animation = Tween(begin: 0.0, end: 1.0).animate(animationController);

    useEffect(() {
      animationController.forward().whenComplete(() {
        Timer(const Duration(seconds: 2), () {
          if (animationController.status == AnimationStatus.completed) {
            animationController.reverse().whenComplete(onDismissed);
          }
        });
      });
      return null;
    }, const []);

    Color backgroundColor = getColorScheme(context).colorGray800;
    String iconPath = "assets/imgs/icon_check_filled.svg";

    if (type == ToastType.Warning) {
      backgroundColor = getColorScheme(context).colorYellow500;
      iconPath = "assets/imgs/icon_warning.svg";
    } else if (type == ToastType.Error) {
      backgroundColor = getColorScheme(context).colorRed500;
      iconPath = "assets/imgs/icon_warning.svg";
    }

    return Positioned(
      left: 0,
      right: 0,
      top: 52,
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: FadeTransition(
            opacity: animation,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      iconPath,
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        getColorScheme(context).white,
                        BlendMode.srcIn,
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          message,
                          style: getTextTheme(context).b3sb.copyWith(
                                color: getColorScheme(context).white,
                                overflow: TextOverflow.visible,
                              ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}