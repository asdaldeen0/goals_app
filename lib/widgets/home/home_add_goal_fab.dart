import 'package:flutter/material.dart';
import 'package:goals/core/app_colors.dart';
import 'package:goals/core/app_typography.dart';

class HomeAddGoalFab extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const HomeAddGoalFab({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: AppColors.ink,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      icon: const Icon(
        Icons.add_rounded,
        color: AppColors.white,
      ),
      label: Text(
        label,
        style: AppTypography.headline.copyWith(
          color: AppColors.white,
          fontSize: 14.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
