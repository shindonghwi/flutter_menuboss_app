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
    );

    final scaleNotifier = useState<ValueNotifier<double>>(
      ValueNotifier(1.0),
    );

    animationController.addListener(() {
      scaleNotifier.value.value = Tween<double>(begin: 1.0, end: 0.98).transform(
        animationController.value,
      );
    });

    useEffect(() {
      return () => animationController.dispose;
    }, const []);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: () {
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
        child: ValueListenableBuilder<double>(
          valueListenable: scaleNotifier.value,
          builder: (context, scale, child) {
            return Transform.scale(scale: scale, child: child);
          },
          child: child,
        ),
      ),
    );
  }
}
