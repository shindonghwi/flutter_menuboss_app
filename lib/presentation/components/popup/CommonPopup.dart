import 'package:flutter/material.dart';

class CommonPopup {
  static void showPopup(
    BuildContext context, {
    double borderRadius = 16.0,
    double contentPadding = 24.0,
    bool barrierDismissible = true,
    Color backgroundColor = Colors.white,
    required Widget child,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return barrierDismissible;
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            ),
            backgroundColor: backgroundColor,
            scrollable: false,
            contentPadding: EdgeInsets.all(contentPadding),
            content: SafeArea(
              child: PopupWidget(
                borderRadius: borderRadius,
                backgroundColor: backgroundColor,
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}

class PopupWidget extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final Color backgroundColor;

  const PopupWidget({
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
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      child: child,
    );
  }
}
