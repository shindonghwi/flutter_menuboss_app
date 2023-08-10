import 'package:flutter/material.dart';


extension StyleColor on ColorScheme{

  Color get colorUIBackground => brightness == Brightness.light ? white : white;
  Color get colorUI01 => brightness == Brightness.light ? neutral10 : neutral10;
  Color get colorUI02 => brightness == Brightness.light ? neutral20 : neutral20;
  Color get colorUI03 => brightness == Brightness.light ? neutral30 : neutral30;
  Color get colorUI04 => brightness == Brightness.light ? neutral40 : neutral40;

  Color get colorText => brightness == Brightness.light ? neutral90 : neutral90;
  Color get colorPrimaryFocus => brightness == Brightness.light ? primary100 : primary100;
  Color get colorPrimaryPress => brightness == Brightness.light ? primary50 : primary50;
  Color get colorPrimaryDisable => brightness == Brightness.light ? neutral40 : neutral40;
  Color get colorError => brightness == Brightness.light ? error80 : error80;


  Color get black => brightness == Brightness.light ? Color(0xFF000000) : Color(0xFF000000);
  Color get white => brightness == Brightness.light ? Color(0xFFFFFFFF) : Color(0xFFFFFFFF);

  Color get primary100 => brightness == Brightness.light ? Color(0xFF4E87FF) : Color(0xFF4E87FF);
  Color get primary90 => brightness == Brightness.light ? Color(0xFF4D86FF) : Color(0xFF4D86FF);
  Color get primary80 => brightness == Brightness.light ? Color(0xFF538BFF) : Color(0xFF538BFF);
  Color get primary70 => brightness == Brightness.light ? Color(0xFF6899FF) : Color(0xFF6899FF);
  Color get primary60 => brightness == Brightness.light ? Color(0xFF719FFF) : Color(0xFF719FFF);
  Color get primary50 => brightness == Brightness.light ? Color(0xFF8AAFFF) : Color(0xFF8AAFFF);
  Color get primary40 => brightness == Brightness.light ? Color(0xFF96B8FF) : Color(0xFF96B8FF);
  Color get primary30 => brightness == Brightness.light ? Color(0xFFB4CDFF) : Color(0xFFB4CDFF);
  Color get primary20 => brightness == Brightness.light ? Color(0xFFCEDEFF) : Color(0xFFCEDEFF);
  Color get primary10 => brightness == Brightness.light ? Color(0xFFE3ECFF) : Color(0xFFE3ECFF);

  Color get secondary100 => brightness == Brightness.light ? Color(0xFFFF9108) : Color(0xFFFF9108);
  Color get secondary20 => brightness == Brightness.light ? Color(0xFFFFDFB7) : Color(0xFFFFDFB7);

  Color get error100 => brightness == Brightness.light ? Color(0xFFFF4242) : Color(0xFFFF4242);
  Color get error90 => brightness == Brightness.light ? Color(0xFFFF5353) : Color(0xFFFF5353);
  Color get error80 => brightness == Brightness.light ? Color(0xFFFF6868) : Color(0xFFFF6868);
  Color get error70 => brightness == Brightness.light ? Color(0xFFFF7878) : Color(0xFFFF7878);
  Color get error60 => brightness == Brightness.light ? Color(0xFFFF9494) : Color(0xFFFF9494);
  Color get error50 => brightness == Brightness.light ? Color(0xFFFFABAB) : Color(0xFFFFABAB);
  Color get error40 => brightness == Brightness.light ? Color(0xFFFFBCBC) : Color(0xFFFFBCBC);
  Color get error30 => brightness == Brightness.light ? Color(0xFFFFCECE) : Color(0xFFFFCECE);
  Color get error20 => brightness == Brightness.light ? Color(0xFFFFE1E1) : Color(0xFFFFE1E1);
  Color get error10 => brightness == Brightness.light ? Color(0xFFFFF8F8) : Color(0xFFFFF8F8);

  Color get neutral100 => brightness == Brightness.light ? Color(0xFF282828) : Color(0xFF282828);
  Color get neutral90 => brightness == Brightness.light ? Color(0xFF474747) : Color(0xFF474747);
  Color get neutral80 => brightness == Brightness.light ? Color(0xFF666666) : Color(0xFF666666);
  Color get neutral70 => brightness == Brightness.light ? Color(0xFF8E8E8E) : Color(0xFF8E8E8E);
  Color get neutral60 => brightness == Brightness.light ? Color(0xFFB7B7B7) : Color(0xFFB7B7B7);
  Color get neutral50 => brightness == Brightness.light ? Color(0xFFD2D2D2) : Color(0xFFD2D2D2);
  Color get neutral40 => brightness == Brightness.light ? Color(0xFFE8E8E8) : Color(0xFFE8E8E8);
  Color get neutral30 => brightness == Brightness.light ? Color(0xFFF5F5F5) : Color(0xFFF5F5F5);
  Color get neutral20 => brightness == Brightness.light ? Color(0xFFFBFBFB) : Color(0xFFFBFBFB);
  Color get neutral10 => brightness == Brightness.light ? Color(0xFFFDFDFD) : Color(0xFFFDFDFD);
}