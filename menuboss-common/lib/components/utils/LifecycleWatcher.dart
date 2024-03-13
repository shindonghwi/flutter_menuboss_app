import 'package:flutter/material.dart';

class LifecycleWatcher extends StatefulWidget {
  final Widget child;
  final Function(dynamic state) onLifeCycleChanged;

  const LifecycleWatcher({
    Key? key,
    required this.child,
    required this.onLifeCycleChanged,
  }) : super(key: key);

  @override
  State<LifecycleWatcher> createState() => _LifecycleWatcherState();
}

class _LifecycleWatcherState extends State<LifecycleWatcher> with WidgetsBindingObserver {
  late AppLifecycleState _lastLifecycleState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        print("## detached");
        break;
      case AppLifecycleState.inactive:
        print("## inactive");
        break;
      case AppLifecycleState.paused:
        print("## paused");
        break;
      case AppLifecycleState.resumed:
        print("## resumed");
        break;
    }

    setState(() {
      widget.onLifeCycleChanged(state);
      _lastLifecycleState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
