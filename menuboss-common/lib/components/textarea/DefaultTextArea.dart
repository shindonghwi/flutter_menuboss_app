import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../ui/colors.dart';
import '../../ui/typography.dart';
import '../../utils/Common.dart';

class DefaultTextArea extends HookWidget {
  final TextEditingController? controller;
  final String hint;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool enable;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final int height;

  const DefaultTextArea.normal({
    Key? key,
    this.controller,
    required this.hint,
    this.enable = true,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters = const [],
    this.onChanged,
  })  : height = 128,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = this.controller ?? useTextEditingController();

    EdgeInsets contentPadding = const EdgeInsets.symmetric(vertical: 8, horizontal: 16);
    int maxLines = 6;
    TextStyle textStyle = getTextTheme(context).b3r;

    switch (height) {
      case 128:
        contentPadding = const EdgeInsets.symmetric(vertical: 12.5, horizontal: 16);
        maxLines = 6;
        textStyle = getTextTheme(context).b3r;
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
            onChanged?.call(text);
          },
          inputFormatters: inputFormatters,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          style: textStyle.copyWith(
            color: getColorScheme(context).colorGray900,
          ),
          textAlign: TextAlign.left,
          textAlignVertical: TextAlignVertical.top,
          enabled: enable,
          maxLines: maxLines,
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
                color: getColorScheme(context).colorGray300,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
                color: getColorScheme(context).colorGray300,
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
                color: getColorScheme(context).colorGray900,
              ),
            ),
            contentPadding: contentPadding,
            counter: null,
            counterText: '',
          ),
        ),
      ],
    );
  }
}
