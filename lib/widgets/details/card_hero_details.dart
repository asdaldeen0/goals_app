import 'package:flutter/material.dart';
import 'package:goals/shared/widgets/category_badge.dart';
import 'package:goals/shared/widgets/goal_status_badge.dart';
import 'package:goals/view_models/goal_details_viewmodel.dart';
import '../../core/app_colors.dart';
import '../../core/app_typography.dart';
import '../../models/goal_model.dart';
import 'goal_details_progress_section.dart';
import 'goal_details_stats_grid.dart';

class GoalHeroDashboardCard extends StatelessWidget {
  final GoalModel goal;
  final GoalDetailsViewModel vm;

  const GoalHeroDashboardCard({
    super.key,
    required this.goal,
    required this.vm,
  });

  @override
  Widget build(BuildContext context) {
    final bool isFinished = goal.isCompleted;
    final Color accentColor = isFinished ? AppColors.completed : AppColors.ink;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.cardAchievementBrass,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.8),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CategoryBadge(category: goal.category),
                const Spacer(),
                GoalStatusBadge(
                  remainingDays: goal.remainingDays,
                  isCompleted: isFinished,
                ),
              ],
            ),

            const SizedBox(height: 18),

            Center(
              child: Text(
                goal.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.displayMedium,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.border.withValues(alpha: 0.6),
                    ),
                  ),
                  child: const Icon(
                    Icons.calendar_month_rounded,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  vm.dateRangeText,
                  style: AppTypography.ledgerNumber.copyWith(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            GoalDetailsProgressSection(
              progressRatio: vm.progressRatio,
              isFinished: isFinished,
              accentColor: accentColor,
            ),

            const SizedBox(height: 18),

            GoalDetailsStatsGrid(goal: goal, isFinished: isFinished),
          ],
        ),
      ),
    );
  }
}
