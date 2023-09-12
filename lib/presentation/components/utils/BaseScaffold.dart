import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class BaseScaffold extends HookWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final bool extendBody;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final Widget? floatingButtonWidget;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const BaseScaffold({
    super.key,
    required this.body,
    this.extendBody = false,
    this.appBar,
    this.backgroundColor,
    this.floatingButtonWidget,
    this.bottomNavigationBar,
    this.floatingActionButtonLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor ?? getColorScheme(context).white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.translucent,
        child: body,
      ),
      extendBody: extendBody,
      floatingActionButton: floatingButtonWidget,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
