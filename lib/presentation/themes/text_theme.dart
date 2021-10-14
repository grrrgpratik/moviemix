import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviemix/common/constants/size_constants.dart';
import 'package:moviemix/common/extension/size_extension.dart';

class ThemeText {
  const ThemeText._();

  static TextTheme get _poppinsTextTheme => GoogleFonts.poppinsTextTheme();
  static TextStyle get _whiteHeadline6 => _poppinsTextTheme.headline6.copyWith(
        fontSize: Sizes.dimen_20.sp,
        color: Colors.white,
      );
  static getTextTheme() => TextTheme(
        headline6: _whiteHeadline6,
      );
}
