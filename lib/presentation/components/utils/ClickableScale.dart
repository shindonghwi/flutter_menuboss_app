import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ClickableScale extends HookWidget {
  final Widget child;
  final double borderRadius;
  final VoidCallback onPressed;

  const ClickableScale({
    Key? key,
    this.borderRadius = 8,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 100),
      initialValue: 1.0,
    );

    final scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: () {
          // 이 부분에서 애니메이션을 빠르게 재생하도록 로직을 추가합니다.
          animationController.forward().then((_) {
            animationController.reverse();
          });
          onPressed();
        },
        onHighlightChanged: (highlighted) {
          if (highlighted) {
            animationController.forward();
          } else {
            animationController.reverse();
          }
        },
        child: AnimatedBuilder(
          animation: scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: scaleAnimation.value,
              child: child,
            );
          },
          child: child,
        ),
      ),
    );
  }
}
