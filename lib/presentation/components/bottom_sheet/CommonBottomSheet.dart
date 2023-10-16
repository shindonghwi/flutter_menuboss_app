import 'package:flutter/material.dart';

class CommonBottomSheet {
  static showBottomSheet(
    BuildContext context, {
    double borderRadius = 20.0,
    Color safeAreaColor = Colors.white,
    Color backgroundColor = Colors.white,
    required Widget child,
    Function? closeAction,
  }) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            decoration: BoxDecoration(
              color: safeAreaColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius),
              ),
            ),
            child: SafeArea(
              child: BottomSheetWidget(
                borderRadius: borderRadius,
                backgroundColor: backgroundColor,
                child: child,
              ),
            ),
          ),
        );
      },
    ).then((value) {
      closeAction?.call();
    });
  }

  static close(BuildContext context, {Function? closeAction}) {
    Navigator.of(context).pop();
    closeAction?.call();
  }
}

class BottomSheetWidget extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final Color backgroundColor;

  const BottomSheetWidget({
    super.key,
    required this.child,
    required this.borderRadius,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      child: child,
    );
  }
}
