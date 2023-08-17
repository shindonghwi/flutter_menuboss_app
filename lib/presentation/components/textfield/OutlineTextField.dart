import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
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
  final bool showPwVisibleButton;
  final bool forceErrorCheck;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;

  const OutlineTextField({
    Key? key,
    this.controller,
    required this.hint,
    this.successMessage = '',
    this.errorMessage = '',
    this.checkRegList = const [],
    this.showPwVisibleButton = false,
    this.forceErrorCheck = false,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters = const [],
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = this.controller ?? useTextEditingController();

    final isSuccess = useState<bool?>(null);

    final isPwVisible = useState(false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
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
          inputFormatters: inputFormatters,
          obscureText: isPwVisible.value ? false : textInputType == TextInputType.visiblePassword,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          style: getTextTheme(context).b2m.copyWith(
                color: getColorScheme(context).colorGray900,
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
            hintStyle: getTextTheme(context).b2m.copyWith(
                  color: getColorScheme(context).colorGray500,
                ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1,
                color: isSuccess.value == true && successMessage.isNotEmpty
                    ? getColorScheme(context).colorGreen500
                    : (forceErrorCheck || isSuccess.value == false) && errorMessage.isNotEmpty
                    ? getColorScheme(context).colorError500
                    : getColorScheme(context).colorGray300,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1,
                color: isSuccess.value == true && successMessage.isNotEmpty
                    ? getColorScheme(context).colorGreen500
                    : (forceErrorCheck || isSuccess.value == false) && errorMessage.isNotEmpty
                        ? getColorScheme(context).colorError500
                        : getColorScheme(context).colorGray300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1,
                color: isSuccess.value == true && successMessage.isNotEmpty
                    ? getColorScheme(context).colorGreen500
                    : (forceErrorCheck || isSuccess.value == false) && errorMessage.isNotEmpty
                    ? getColorScheme(context).colorError500
                    : getColorScheme(context).colorGray300,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 12,
            ),
            suffixIconConstraints: const BoxConstraints(minHeight: 24, minWidth: 24),
            counter: null,
            counterText: '',
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
                          child: SvgPicture.asset(
                            isPwVisible.value == true ? "assets/imgs/icon_view.svg" : "assets/imgs/icon_view_hide.svg",
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              getColorScheme(context).colorGray500,
                              BlendMode.srcIn,
                            )
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (isSuccess.value == true && successMessage.isNotEmpty)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(Icons.check, color: Colors.green, size: 14),
              ),
              Text(
                successMessage.toString(),
                style: getTextTheme(context).c2m.copyWith(
                      color: getColorScheme(context).colorGreen500,
                    ),
              ),
            ],
          ),
        if ((forceErrorCheck || isSuccess.value == false) && errorMessage.isNotEmpty)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(Icons.error, color: Colors.red, size: 14),
              ),
              Text(
                errorMessage.toString(),
                style: getTextTheme(context).c2m.copyWith(
                      color: getColorScheme(context).colorError500,
                    ),
              ),
            ],
          ),
      ],
    );
  }
}
