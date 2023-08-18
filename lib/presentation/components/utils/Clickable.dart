import 'package:flutter/material.dart';

class Clickable extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final VoidCallback onPressed;

  const Clickable({
    super.key,
    this.borderRadius = 8,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: () => onPressed.call(),
        child: child,
      ),
    );
  }
}
