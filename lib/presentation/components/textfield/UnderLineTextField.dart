import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class UnderLineTextField extends HookWidget {
  final TextEditingController? controller;
  final int maxLength;
  final String hint;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;

  const UnderLineTextField({
    Key? key,
    this.controller,
    required this.maxLength,
    required this.hint,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters = const [],
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = this.controller ?? useTextEditingController();

    final textState = useState(controller.text);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          onChanged: (text) {
            textState.value = text;
            onChanged?.call(text);
          },
          inputFormatters: inputFormatters,
          obscureText: textInputType == TextInputType.visiblePassword,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          style: getTextTheme(context).b1m.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
          onSubmitted: (text) {
            if (textInputAction == TextInputAction.next) {
              FocusScope.of(context).nextFocus();
            } else if (textInputAction == TextInputAction.done) {
              FocusScope.of(context).unfocus();
            }
          },
          maxLength: maxLength,
          decoration: InputDecoration(
            isCollapsed: true,
            hintText: hint,
            hintStyle: getTextTheme(context).b1m.copyWith(
                  color: getColorScheme(context).colorGray500,
                ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: getColorScheme(context).colorGray200,
                width: 1.0, // Adjust the width as needed
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: getColorScheme(context).colorGray200,
                width: 1.0, // Adjust the width as needed
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: getColorScheme(context).colorGray900,
                width: 1.0, // Adjust the width as needed
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 4,
            ),
            suffixIconConstraints: const BoxConstraints(minHeight: 24, minWidth: 24),
            counter: null,
            counterText: '',
            suffixIcon: Container(
              margin: const EdgeInsets.only(right: 4),
              child: Text(
                "${textState.value.length} / $maxLength",
                style: getTextTheme(context).b2m.copyWith(
                      color: getColorScheme(context).colorGray500,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
