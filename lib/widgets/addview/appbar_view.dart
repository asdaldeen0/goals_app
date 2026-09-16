import 'package:flutter/material.dart';
import 'package:goals/core/app_colors.dart';
import 'package:goals/core/app_typography.dart';

class AppBarAdd extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final IconData backIcon;
  const AppBarAdd({
    super.key,
    required this.title,
    required this.onBack,
    this.backIcon = Icons.arrow_back_ios_new_rounded,
  });

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: AppTypography.displayMedium.copyWith(
          color: AppColors.textMain,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.cardSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(backIcon, size: 16, color: AppColors.textMain),
            onPressed: onBack,
          ),
        ),
      ),
    );
  }
}
