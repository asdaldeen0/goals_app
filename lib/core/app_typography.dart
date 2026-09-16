import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();


  static TextStyle get displayLarge => GoogleFonts.amiri(
    fontSize: 34,
    fontWeight: FontWeight.w700,
    color: AppColors.textMain,
    height: 1.3,
  );

  static TextStyle get displayMedium => GoogleFonts.amiri(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textMain,
    height: 1.35,
  );


  static TextStyle get headline => GoogleFonts.ibmPlexSansArabic(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textMain,
  );

  static TextStyle get body => GoogleFonts.ibmPlexSansArabic(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textMain,
    height: 1.5,
  );

  static TextStyle get bodySecondary => GoogleFonts.ibmPlexSansArabic(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static TextStyle get label => GoogleFonts.ibmPlexSansArabic(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textMuted,
  );


  static TextStyle get ledgerNumber => GoogleFonts.ibmPlexSansArabic(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textMain,
    fontFeatures: const [FontFeature.tabularFigures()],
  );
}
