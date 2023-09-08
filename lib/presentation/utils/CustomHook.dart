import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomHook {
  static GlobalKey<T> useGlobalKey<T extends State<StatefulWidget>>() {
    final key = useMemoized(() => GlobalKey<T>(), []);
    return key;
  }
}
