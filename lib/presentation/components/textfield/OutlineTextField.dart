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
  final bool showSuffixStatusIcon;
  final bool forceRedCheck;
  final bool enable;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final double height;

  const OutlineTextField.xsmall({
    Key? key,
    this.controller,
    required this.hint,
    this.successMessage = '',
    this.errorMessage = '',
    this.checkRegList = const [],
    this.showPwVisibleButton = false,
    this.showSuffixStatusIcon = true,
    this.forceRedCheck = false,
    this.enable = true,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters = const [],
    this.onChanged,
  })  : height = 32,
        super(key: key);

  const OutlineTextField.small({
    Key? key,
    this.controller,
    required this.hint,
    this.successMessage = '',
    this.errorMessage = '',
    this.checkRegList = const [],
    this.showPwVisibleButton = false,
    this.showSuffixStatusIcon = true,
    this.forceRedCheck = false,
    this.enable = true,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters = const [],
    this.onChanged,
  })  : height = 44,
        super(key: key);

  const OutlineTextField.medium({
    Key? key,
    this.controller,
    required this.hint,
    this.successMessage = '',
    this.errorMessage = '',
    this.checkRegList = const [],
    this.showPwVisibleButton = false,
    this.showSuffixStatusIcon = true,
    this.forceRedCheck = false,
    this.enable = true,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters = const [],
    this.onChanged,
  })  : height = 48,
        super(key: key);

  const OutlineTextField.large({
    Key? key,
    this.controller,
    required this.hint,
    this.successMessage = '',
    this.errorMessage = '',
    this.checkRegList = const [],
    this.showPwVisibleButton = false,
    this.showSuffixStatusIcon = true,
    this.forceRedCheck = false,
    this.enable = true,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters = const [],
    this.onChanged,
  })  : height = 52,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = this.controller ?? useTextEditingController();

    final isSuccess = useState<bool?>(null);
    final isPwVisible = useState(false);
    EdgeInsets contentPadding = const EdgeInsets.symmetric(vertical: 8, horizontal: 16);
    TextStyle textStyle = getTextTheme(context).b3m;

    switch (height) {
      case 32:
        contentPadding = const EdgeInsets.symmetric(vertical: 12.5, horizontal: 16);
        textStyle = getTextTheme(context).c1m;
        break;
      case 44:
        contentPadding = const EdgeInsets.symmetric(vertical: 12.5, horizontal: 16);
        textStyle = getTextTheme(context).b3m;
        break;
      case 48:
        contentPadding = const EdgeInsets.symmetric(vertical: 14.5, horizontal: 16);
        textStyle = getTextTheme(context).b3m;
        break;
      case 52:
        contentPadding = const EdgeInsets.symmetric(vertical: 15, horizontal: 16);
        textStyle = getTextTheme(context).b2m;
        break;
      default:
        break;
    }

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

            if (isSuccess.value == false && forceRedCheck) {
              isSuccess.value = forceRedCheck;
            }

            onChanged?.call(text);
          },
          inputFormatters: inputFormatters,
          obscureText: isPwVisible.value ? false : textInputType == TextInputType.visiblePassword,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          style: textStyle.copyWith(
            color: getColorScheme(context).colorGray900,
          ),
          enabled: enable,
          onSubmitted: (text) {
            if (textInputAction == TextInputAction.next) {
              FocusScope.of(context).nextFocus();
            } else if (textInputAction == TextInputAction.done) {
              FocusScope.of(context).unfocus();
            }
          },
          decoration: InputDecoration(
            isCollapsed: true,
            filled: true,
            fillColor: enable ? getColorScheme(context).white : getColorScheme(context).colorGray100,
            hintText: hint,
            hintStyle: textStyle.copyWith(
              color: getColorScheme(context).colorGray400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
                color: isSuccess.value == true && successMessage.isNotEmpty
                    ? getColorScheme(context).colorGreen500
                    : (forceRedCheck || isSuccess.value == false) && errorMessage.isNotEmpty
                        ? getColorScheme(context).colorRed500
                        : getColorScheme(context).colorGray300,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
                color: isSuccess.value == true && successMessage.isNotEmpty
                    ? getColorScheme(context).colorGreen500
                    : (forceRedCheck || isSuccess.value == false) && errorMessage.isNotEmpty
                        ? getColorScheme(context).colorRed500
                        : getColorScheme(context).colorGray300,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
                color: getColorScheme(context).colorGray300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
                color: isSuccess.value == true && successMessage.isNotEmpty
                    ? getColorScheme(context).colorGreen500
                    : (forceRedCheck || isSuccess.value == false) && errorMessage.isNotEmpty
                        ? getColorScheme(context).colorRed500
                        : getColorScheme(context).colorGray900,
              ),
            ),
            contentPadding: contentPadding,
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
                              isPwVisible.value == true
                                  ? "assets/imgs/icon_view_on.svg"
                                  : "assets/imgs/icon_view_hide.svg",
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                getColorScheme(context).colorGray500,
                                BlendMode.srcIn,
                              )),
                        ),
                      ),
                    ),
                  if (showSuffixStatusIcon && isSuccess.value == true && successMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SvgPicture.asset(
                        "assets/imgs/icon_check_filled.svg",
                        width: 16,
                        height: 16,
                        colorFilter: ColorFilter.mode(
                          getColorScheme(context).colorGreen500,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  if (showSuffixStatusIcon && (forceRedCheck || isSuccess.value == false) && errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SvgPicture.asset(
                        "assets/imgs/icon_warning.svg",
                        width: 16,
                        height: 16,
                        colorFilter: ColorFilter.mode(
                          getColorScheme(context).colorRed500,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (isSuccess.value == true && successMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              successMessage.toString(),
              style: getTextTheme(context).c1m.copyWith(
                    color: getColorScheme(context).colorGreen500,
                  ),
            ),
          ),
        if ((forceRedCheck || isSuccess.value == false) && errorMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              errorMessage.toString(),
              style: getTextTheme(context).c1m.copyWith(
                    color: getColorScheme(context).colorRed500,
                  ),
            ),
          ),
      ],
    );
  }
}
