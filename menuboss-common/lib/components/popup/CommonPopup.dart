import 'package:flutter/material.dart';

import '../../utils/Common.dart';

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
          child: Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: getMediaQuery(context).size.width * 0.065),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            ),
            backgroundColor: backgroundColor,
            child: SafeArea(
              child: PopupWidget(
                borderRadius: borderRadius,
                backgroundColor: backgroundColor,
                child: Padding(
                  padding: EdgeInsets.all(contentPadding),
                  child: child,
                ),
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
    Key? key,
    required this.child,
    required this.borderRadius,
    required this.backgroundColor,
  }) : super(key: key);

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
