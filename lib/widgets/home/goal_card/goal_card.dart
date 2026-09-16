import 'package:flutter/material.dart';
import 'package:goals/core/app_colors.dart';
import 'package:goals/core/app_typography.dart';
import 'goal_card_date_footer.dart';
import 'goal_card_header.dart';
import 'goal_card_progress.dart';

class GoalCard extends StatelessWidget {
  final String title;
  final String category;
  final String dateRange;
  final int remainingDays;
  final int completedSubGoals;
  final int totalSubGoals;
  final double progressRatio;
  final bool isCompleted;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const GoalCard({
    super.key,
    required this.title,
    required this.category,
    required this.dateRange,
    required this.remainingDays,
    required this.completedSubGoals,
    required this.totalSubGoals,
    required this.progressRatio,
    required this.isCompleted,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isCompleted
              ? AppColors.completed.withValues(alpha: 0.25)
              : AppColors.border,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GoalCardHeader(
                  category: category,
                  remainingDays: remainingDays,
                  isCompleted: isCompleted,
                  onEdit: onEdit,
                  onDelete: onDelete,
                ),

                const SizedBox(height: 14),

                Text(
                  title,
                  textAlign: TextAlign.start,
                  style: AppTypography.displayMedium.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 14),

                GoalCardProgress(
                  progressRatio: progressRatio,
                  completedSubGoals: completedSubGoals,
                  totalSubGoals: totalSubGoals,
                  isCompleted: isCompleted,
                ),

                const SizedBox(height: 12),

                GoalCardDateFooter(dateRange: dateRange),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
