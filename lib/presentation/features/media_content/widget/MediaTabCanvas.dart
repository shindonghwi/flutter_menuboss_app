import 'package:flutter/material.dart';

class MediaTabCanvas extends StatelessWidget {
  const MediaTabCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(title: Text('Canvas Image 1')),
        ListTile(title: Text('Canvas Image 2')),
      ],
    );
  }
}
