import 'package:flutter/material.dart';
import 'package:goals/core/app_colors.dart';
import 'package:goals/core/app_typography.dart';

class GoalCardProgress extends StatelessWidget {
  final double progressRatio;
  final int completedSubGoals;
  final int totalSubGoals;
  final bool isCompleted;

  const GoalCardProgress({
    super.key,
    required this.progressRatio,
    required this.completedSubGoals,
    required this.totalSubGoals,
    required this.isCompleted,
  });

  int get progressPercentage => (progressRatio * 100).toInt();

  @override
  Widget build(BuildContext context) {
    final Color accentColor =
        isCompleted ? AppColors.completed : AppColors.ink;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: progressRatio),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
          builder: (context, animatedRatio, child) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: animatedRatio,
                minHeight: 7,
                backgroundColor: AppColors.border,
                valueColor: AlwaysStoppedAnimation<Color>(accentColor),
              ),
            );
          },
        ),

        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$progressPercentage%',
              style: AppTypography.ledgerNumber.copyWith(
                color: accentColor,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '$completedSubGoals من $totalSubGoals خطوات منجزة',
              style: AppTypography.bodySecondary.copyWith(
                color: AppColors.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
