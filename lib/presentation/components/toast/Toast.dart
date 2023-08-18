import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class ToastUtil {
  static OverlayEntry? _overlay;

  static void errorToast(String message) async {
    final context = MenuBossGlobalVariable.navigatorKey.currentContext as BuildContext;

    if (Navigator.of(context).overlay?.mounted == true) {
      _overlay?.remove(); // 저장한 OverlayEntry 해제
      _overlay = null;
    }

    if (message.isNotEmpty) {
      _overlay = OverlayEntry(builder: (_) => Toast(type: ToastType.Error, message: message, overlay: _overlay));
      Navigator.of(context).overlay?.insert(_overlay!);
    }
  }

  static void warningToast(String message) async {
    final context = MenuBossGlobalVariable.navigatorKey.currentContext as BuildContext;

    if (Navigator.of(context).overlay?.mounted == true) {
      _overlay?.remove(); // 저장한 OverlayEntry 해제
      _overlay = null;
    }

    if (message.isNotEmpty) {
      _overlay = OverlayEntry(builder: (_) => Toast(type: ToastType.Warning, message: message, overlay: _overlay));
      Navigator.of(context).overlay?.insert(_overlay!);
    }
  }

  static void successToast(String message) async {
    final context = MenuBossGlobalVariable.navigatorKey.currentContext as BuildContext;

    if (Navigator.of(context).overlay?.mounted == true) {
      _overlay?.remove(); // 저장한 OverlayEntry 해제
      _overlay = null;
    }

    if (message.isNotEmpty) {
      _overlay = OverlayEntry(builder: (_) => Toast(type: ToastType.Success, message: message, overlay: _overlay));
      Navigator.of(context).overlay?.insert(_overlay!);
    }
  }
}

enum ToastType { Success, Error, Warning }

class Toast extends StatefulWidget {
  final ToastType type;
  final String message;
  final OverlayEntry? overlay;

  const Toast({
    Key? key,
    required this.type,
    required this.message,
    required this.overlay,
  }) : super(key: key);

  @override
  _ToastState createState() => _ToastState();
}

class _ToastState extends State<Toast> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slideAnimation = TweenSequence<Offset>([
      TweenSequenceItem<Offset>(
        tween: Tween<Offset>(begin: const Offset(0.0, -0.2), end: const Offset(0.0, 0.5)),
        weight: 1,
      ),
      TweenSequenceItem<Offset>(
        tween: Tween<Offset>(begin: const Offset(0.0, 0.3), end: const Offset(0.0, 0.9))
            .chain(CurveTween(curve: Curves.bounceOut)),
        weight: 3,
      ),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _startFadeOutAnimation();
      }
    });

    _controller.forward();
  }

  Future<void> _startFadeOutAnimation() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    await _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.only(top: 60.0),
          child: SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: getMediaQuery(context).size.width * 0.9,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: widget.type == ToastType.Success
                        ? getColorScheme(context).colorGreen500
                        : widget.type == ToastType.Error
                        ? getColorScheme(context).colorError500
                        : getColorScheme(context).colorYellow500,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.type == ToastType.Error)
                        Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: SvgPicture.asset(
                            widget.type == ToastType.Success
                                ? "assets/imgs/icon_success.svg"
                                : widget.type == ToastType.Error
                                ? "assets/imgs/icon_info.svg"
                                : "assets/imgs/icon_error.svg",
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(getColorScheme(context).white, BlendMode.srcIn),
                          ),
                        ),
                      Text(
                        widget.message.toString(),
                        style: getTextTheme(context).b1sb.copyWith(color: getColorScheme(context).white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
