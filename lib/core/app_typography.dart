import 'dart:ui';
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  static const String _amiriFont = 'Amiri';
  static const String _ibmFont = 'IBMPlexSansArabic';

  static TextStyle get displayLarge => const TextStyle(
        fontFamily: _amiriFont,
        fontSize: 34,
        fontWeight: FontWeight.w700,
        color: AppColors.textMain,
        height: 1.3,
      );

  static TextStyle get displayMedium => const TextStyle(
        fontFamily: _amiriFont,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.textMain,
        height: 1.35,
      );

  static TextStyle get headline => const TextStyle(
        fontFamily: _ibmFont,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textMain,
      );

  static TextStyle get body => const TextStyle(
        fontFamily: _ibmFont,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: AppColors.textMain,
        height: 1.5,
      );

  static TextStyle get bodySecondary => const TextStyle(
        fontFamily: _ibmFont,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.5,
      );

  static TextStyle get label => const TextStyle(
        fontFamily: _ibmFont,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textMuted,
      );

  static TextStyle get ledgerNumber => const TextStyle(
        fontFamily: _ibmFont,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textMain,
        fontFeatures: [FontFeature.tabularFigures()],
      );
}