import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class BasicBorderCheckBox extends HookWidget {
  final String label;
  final bool isChecked;
  final Function(bool) onChange;

  const BasicBorderCheckBox({
    super.key,
    this.label = "",
    required this.isChecked,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final checkState = useState(isChecked);
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 200),
    );

    useEffect(() {
      if (checkState.value) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
      return null;
    }, [checkState.value]);

    void toggleCheckbox() {
      checkState.value = !checkState.value;
      onChange(checkState.value);
    }

    return GestureDetector(
      onTap: toggleCheckbox,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            child: checkState.value
                ? Align(
                    key: const Key('unchecked'),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      width: 24,
                      height: 24,
                      "assets/imgs/icon_check.svg",
                      colorFilter: ColorFilter.mode(
                        getColorScheme(context).colorGray300,
                        BlendMode.srcIn,
                      ),
                    ),
                  )
                : Align(
                    key: const Key('checked'),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      width: 24,
                      height: 24,
                      "assets/imgs/icon_check.svg",
                      colorFilter: ColorFilter.mode(
                        getColorScheme(context).colorPrimary500,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
          ),
          if (label.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                label,
                style: getTextTheme(context).b1sb.copyWith(
                      color: getColorScheme(context).black,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
