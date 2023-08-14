import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:menuboss/presentation/utils/RegUtil.dart';

class OutlineTextField extends HookWidget {
  final TextEditingController? controller;
  final String hint;
  final String successMessage;
  final String errorMessage;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final List<RegCheckType> checkRegList;
  final bool showCheckButton;
  final bool showPwVisibleButton;
  final bool forceErrorCheck;
  final Function(String)? onChanged;

  const OutlineTextField({
    Key? key,
    this.controller,
    required this.hint,
    this.successMessage = '',
    this.errorMessage = '',
    this.checkRegList = const [],
    this.showCheckButton = false,
    this.showPwVisibleButton = false,
    this.forceErrorCheck = false,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = this.controller ?? useTextEditingController();

    final isSuccess = useState<bool?>(null);

    final isPwVisible = useState(false);

    return TextField(
      controller: controller,
      onChanged: (text) {
        for (var element in checkRegList) {
          if (element == RegCheckType.Email) {
            isSuccess.value = RegUtil.checkEmail(text);
          }
          if (element == RegCheckType.PW) {
            isSuccess.value = RegUtil.checkPw(text);
          }
          if (element == RegCheckType.Nickname) {
            isSuccess.value = RegUtil.checkNickname(text);
          }
        }

        if (isSuccess.value == false && forceErrorCheck) {
          isSuccess.value = forceErrorCheck;
        }

        onChanged?.call(text);
      },
      obscureText: isPwVisible.value ? false : textInputType == TextInputType.visiblePassword,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      style: getTextTheme(context).bodyLarge?.copyWith(
            color: Colors.blue,
          ),
      onSubmitted: (text) {
        if (textInputAction == TextInputAction.next) {
          FocusScope.of(context).nextFocus();
        } else if (textInputAction == TextInputAction.done) {
          FocusScope.of(context).unfocus();
        }
      },
      decoration: InputDecoration(
        isCollapsed: true,
        hintText: hint,
        hintStyle: getTextTheme(context).bodyLarge?.copyWith(
              color: Colors.blue,
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 5,
            color: Colors.blue,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1,
            color: Colors.blue,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        suffixIconConstraints: const BoxConstraints(minHeight: 24, minWidth: 24),
        counter: null,
        counterText: '',
        helperText: isSuccess.value == true && successMessage.isNotEmpty ? successMessage : null,
        helperStyle: getTextTheme(context).bodyLarge?.copyWith(
              color: getColorScheme(context).error,
            ),
        errorText: forceErrorCheck || isSuccess.value == false && errorMessage.isNotEmpty ? errorMessage : null,
        errorStyle: getTextTheme(context).bodyLarge?.copyWith(
              color: getColorScheme(context).error,
            ),
        suffixIcon: Container(
          margin: const EdgeInsets.only(right: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showPwVisibleButton)
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => isPwVisible.value = !isPwVisible.value,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(
                        isPwVisible.value == true ? "assets/imgs/icon_view.png" : "assets/imgs/icon_hide.png",
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ),
              if (showCheckButton)
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: Image.asset(
                    isSuccess.value == true ? "assets/imgs/icon_check_on.png" : "assets/imgs/icon_check_off.png",
                    width: 24,
                    height: 24,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
