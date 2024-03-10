import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/navigation/Route.dart';

PageRoute nextSlideHorizontalScreen(
  String route, {
  dynamic parameter,
  dynamic parameter1,
  fullScreen = false,
}) {
  if (Platform.isIOS) {
    return CupertinoPageRoute(
      builder: (context) => RoutingScreen.getScreen(
        route,
        parameter: parameter,
        parameter1: parameter1,
      ),
    );
  } else {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => RoutingScreen.getScreen(
        route,
        parameter: parameter,
        parameter1: parameter1,
      ),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      fullscreenDialog: fullScreen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position:
              Tween(begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0)).animate(animation),
          child: child,
        );
      },
    );
  }
}

PageRoute nextFadeInOutScreen(String route,
    {dynamic parameter, dynamic parameter1, fullScreen = false}) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => RoutingScreen.getScreen(
      route,
      parameter: parameter,
      parameter1: parameter1,
    ),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    fullscreenDialog: fullScreen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

PageRoute nextSlideVerticalScreen(String route,
    {dynamic parameter, dynamic parameter1, fullScreen = false}) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => RoutingScreen.getScreen(
      route,
      parameter: parameter,
      parameter1: parameter1,
    ),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    fullscreenDialog: fullScreen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(0, 1);
      var end = const Offset(0, 0);
      var curve = Curves.fastOutSlowIn;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var curvedAnimation = animation.drive(tween);

      return SlideTransition(
        position: curvedAnimation,
        child: child,
      );
    },
  );
}

void popPageWrapper({required BuildContext context, String? movePage}) {
  String route = movePage ?? RoutingScreen.Main.route;

  if (Navigator.canPop(context)) {
    Navigator.pop(context);
  } else {
    Navigator.pushAndRemoveUntil(
      context,
      nextFadeInOutScreen(route),
      (route) => false,
    );
  }
}

void movePage(RoutingScreen screen, {dynamic parameter}) {
  MenuBossGlobalVariable.navigatorKey.currentState!.pushReplacement(
    nextFadeInOutScreen(screen.route, parameter: parameter),
  );
}

void handleDeepLink(String? link, {dynamic parameter}) {
  debugPrint("handleDeepLink: $link");

  if (link == null) return;

  if (link.contains(RoutingScreen.Login.route)) {
    movePage(RoutingScreen.Login, parameter: parameter);
  } else if (link.contains(RoutingScreen.SignUp.route)) {
    movePage(RoutingScreen.SignUp, parameter: parameter);
  } else if (link.contains(RoutingScreen.ScanQR.route)) {
    movePage(RoutingScreen.ScanQR, parameter: parameter);
  } else if (link.contains(RoutingScreen.DetailPlaylist.route)) {
    movePage(RoutingScreen.DetailPlaylist, parameter: parameter);
  } else if (link.contains(RoutingScreen.CreatePlaylist.route)) {
    movePage(RoutingScreen.CreatePlaylist, parameter: parameter);
  } else if (link.contains(RoutingScreen.PreviewPlaylist.route)) {
    movePage(RoutingScreen.PreviewPlaylist, parameter: parameter);
  } else if (link.contains(RoutingScreen.DetailSchedule.route)) {
    movePage(RoutingScreen.DetailSchedule, parameter: parameter);
  } else if (link.contains(RoutingScreen.CreateSchedule.route)) {
    movePage(RoutingScreen.CreateSchedule, parameter: parameter);
  } else if (link.contains(RoutingScreen.MediaInfo.route)) {
    movePage(RoutingScreen.MediaInfo, parameter: parameter);
  } else if (link.contains(RoutingScreen.MediaDetailInFolder.route)) {
    movePage(RoutingScreen.MediaDetailInFolder, parameter: parameter);
  }
}
