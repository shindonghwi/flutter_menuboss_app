import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BaseScaffold extends HookWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final bool extendBody;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const BaseScaffold({super.key,
    required this.body,
    this.extendBody = false,
    this.appBar,
    this.backgroundColor,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.floatingActionButtonLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        behavior: HitTestBehavior.translucent,
        child: body,
      ),
      extendBody: extendBody,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
