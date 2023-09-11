import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseCloudMessage {
  static FirebaseMessaging? fbMsg;

  /// Firebase 디바이스 토큰 받아오기
  static Future<String?> getToken() async {
    String? token = await fbMsg?.getToken();
    debugPrint("device token: $token");
    return token;
  }
}
