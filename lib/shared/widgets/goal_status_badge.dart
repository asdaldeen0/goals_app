import 'package:flutter/material.dart';
import 'package:goals/core/app_colors.dart';
import 'package:goals/core/app_typography.dart';
import 'package:goals/core/utils/date_formatter.dart';

class GoalStatusBadge extends StatelessWidget {
  final int remainingDays;
  final bool isCompleted;

  const GoalStatusBadge({
    super.key,
    required this.remainingDays,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    if (isCompleted) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4.5),
        decoration: BoxDecoration(
          color: AppColors.completed.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle_rounded,
              size: 12.5,
              color: AppColors.completed,
            ),
            const SizedBox(width: 4),
            Text(
              'مكتمل',
              style: AppTypography.label.copyWith(
                color: AppColors.completed,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );
    }

    final bool isUrgent = remainingDays <= 2;
    final Color badgeColor = isUrgent ? AppColors.seal : AppColors.ink;
    final String text = AppDateFormatter.getRemainingDaysText(remainingDays);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4.5),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isUrgent ? Icons.warning_amber_rounded : Icons.schedule_rounded,
            size: 12.5,
            color: badgeColor,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: AppTypography.label.copyWith(
              color: badgeColor,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
