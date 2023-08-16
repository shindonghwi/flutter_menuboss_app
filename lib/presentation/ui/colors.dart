import 'package:flutter/material.dart';


extension StyleColor on ColorScheme{

  Color get black => brightness == Brightness.light ? const Color(0xFF000000) : const Color(0xFF000000);
  Color get white => brightness == Brightness.light ? const Color(0xFFFFFFFF) : const Color(0xFFFFFFFF);

  Color get colorBrown900 => brightness == Brightness.light ? const Color(0xFF0E0702) : const Color(0xFF0E0702);
  Color get colorBrown800 => brightness == Brightness.light ? const Color(0xFF1D0E04) : const Color(0xFF1D0E04);
  Color get colorBrown700 => brightness == Brightness.light ? const Color(0xFF2B1605) : const Color(0xFF2B1605);
  Color get colorBrown600 => brightness == Brightness.light ? const Color(0xFF3A1D07) : const Color(0xFF3A1D07);
  Color get colorBrown500 => brightness == Brightness.light ? const Color(0xFF482409) : const Color(0xFF482409);
  Color get colorBrown400 => brightness == Brightness.light ? const Color(0xFF6D503A) : const Color(0xFF6D503A);
  Color get colorBrown300 => brightness == Brightness.light ? const Color(0xFF917C6B) : const Color(0xFF917C6B);
  Color get colorBrown200 => brightness == Brightness.light ? const Color(0xFFB6A79D) : const Color(0xFFB6A79D);
  Color get colorBrown100 => brightness == Brightness.light ? const Color(0xFFDAD3CE) : const Color(0xFFDAD3CE);
  Color get colorBrown50 => brightness == Brightness.light ? const Color(0xFFEDE9E6) : const Color(0xFFEDE9E6);

  Color get colorOrange900 => brightness == Brightness.light ? const Color(0xFF271409) : const Color(0xFF271409);
  Color get colorOrange800 => brightness == Brightness.light ? const Color(0xFF4D2913) : const Color(0xFF4D2913);
  Color get colorOrange700 => brightness == Brightness.light ? const Color(0xFF743D1C) : const Color(0xFF743D1C);
  Color get colorOrange600 => brightness == Brightness.light ? const Color(0xFF9A5226) : const Color(0xFF9A5226);
  Color get colorOrange500 => brightness == Brightness.light ? const Color(0xFFC1662F) : const Color(0xFFC1662F);
  Color get colorOrange400 => brightness == Brightness.light ? const Color(0xFFCD8559) : const Color(0xFFCD8559);
  Color get colorOrange300 => brightness == Brightness.light ? const Color(0xFFDAA382) : const Color(0xFFDAA382);
  Color get colorOrange200 => brightness == Brightness.light ? const Color(0xFFE6C2AC) : const Color(0xFFE6C2AC);
  Color get colorOrange100 => brightness == Brightness.light ? const Color(0xFFF3E0D5) : const Color(0xFFF3E0D5);
  Color get colorOrange50 => brightness == Brightness.light ? const Color(0xFFF9F0EA) : const Color(0xFFF9F0EA);

  Color get colorGreen900 => brightness == Brightness.light ? const Color(0xFF00220E) : const Color(0xFF00220E);
  Color get colorGreen800 => brightness == Brightness.light ? const Color(0xFF00441C) : const Color(0xFF00441C);
  Color get colorGreen700 => brightness == Brightness.light ? const Color(0xFF00662B) : const Color(0xFF00662B);
  Color get colorGreen600 => brightness == Brightness.light ? const Color(0xFF008839) : const Color(0xFF008839);
  Color get colorGreen500 => brightness == Brightness.light ? const Color(0xFF00AA47) : const Color(0xFF00AA47);
  Color get colorGreen400 => brightness == Brightness.light ? const Color(0xFFCD8559) : const Color(0xFFCD8559);
  Color get colorGreen300 => brightness == Brightness.light ? const Color(0xFFDAA382) : const Color(0xFFDAA382);
  Color get colorGreen200 => brightness == Brightness.light ? const Color(0xFFE6C2AC) : const Color(0xFFE6C2AC);
  Color get colorGreen100 => brightness == Brightness.light ? const Color(0xFFF3E0D5) : const Color(0xFFF3E0D5);
  Color get colorGreen50 => brightness == Brightness.light ? const Color(0xFFF9F0EA) : const Color(0xFFF9F0EA);

  Color get colorYellow900 => brightness == Brightness.light ? const Color(0xFF30280F) : const Color(0xFF30280F);
  Color get colorYellow800 => brightness == Brightness.light ? const Color(0xFF61501E) : const Color(0xFF61501E);
  Color get colorYellow700 => brightness == Brightness.light ? const Color(0xFF91792E) : const Color(0xFF91792E);
  Color get colorYellow600 => brightness == Brightness.light ? const Color(0xFFC2A13D) : const Color(0xFFC2A13D);
  Color get colorYellow500 => brightness == Brightness.light ? const Color(0xFFF2C94C) : const Color(0xFFF2C94C);
  Color get colorYellow400 => brightness == Brightness.light ? const Color(0xFFF5D470) : const Color(0xFFF5D470);
  Color get colorYellow300 => brightness == Brightness.light ? const Color(0xFFF7DF94) : const Color(0xFFF7DF94);
  Color get colorYellow200 => brightness == Brightness.light ? const Color(0xFFFAE9B7) : const Color(0xFFFAE9B7);
  Color get colorYellow100 => brightness == Brightness.light ? const Color(0xFFFCF4DB) : const Color(0xFFFCF4DB);
  Color get colorYellow50 => brightness == Brightness.light ? const Color(0xFFFEFAED) : const Color(0xFFFEFAED);

  Color get colorError900 => brightness == Brightness.light ? const Color(0xFF2F1111) : const Color(0xFF2F1111);
  Color get colorError800 => brightness == Brightness.light ? const Color(0xFF5E2323) : const Color(0xFF5E2323);
  Color get colorError700 => brightness == Brightness.light ? const Color(0xFF8D3434) : const Color(0xFF8D3434);
  Color get colorError600 => brightness == Brightness.light ? const Color(0xFFBC4646) : const Color(0xFFBC4646);
  Color get colorError500 => brightness == Brightness.light ? const Color(0xFFEB5757) : const Color(0xFFEB5757);
  Color get colorError400 => brightness == Brightness.light ? const Color(0xFFEF7979) : const Color(0xFFEF7979);
  Color get colorError300 => brightness == Brightness.light ? const Color(0xFFF39A9A) : const Color(0xFFF39A9A);
  Color get colorError200 => brightness == Brightness.light ? const Color(0xFFF7BCBC) : const Color(0xFFF7BCBC);
  Color get colorError100 => brightness == Brightness.light ? const Color(0xFFFBDDDD) : const Color(0xFFFBDDDD);
  Color get colorError50 => brightness == Brightness.light ? const Color(0xFFFDEEEE) : const Color(0xFFFDEEEE);

}