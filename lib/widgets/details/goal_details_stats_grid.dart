import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_typography.dart';
import '../../models/goal_model.dart';

class GoalDetailsStatsGrid extends StatelessWidget {
  final GoalModel goal;
  final bool isFinished;

  const GoalDetailsStatsGrid({
    super.key,
    required this.goal,
    required this.isFinished,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.7),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              icon: Icons.format_list_bulleted_rounded,
              label: 'الإجمالي',
              value: '${goal.subGoals.length}',
              color: AppColors.ink,
            ),
          ),
          Container(
            width: 1,
            height: 32,
            color: AppColors.border,
          ),
          Expanded(
            child: _buildStatItem(
              icon: Icons.check_circle_rounded,
              label: 'المنجز',
              value: '${goal.completedSubGoalsCount}',
              color: AppColors.completed,
            ),
          ),
          Container(
            width: 1,
            height: 32,
            color: AppColors.border,
          ),
          Expanded(
            child: _buildStatItem(
              icon: Icons.pending_actions_rounded,
              label: 'المتبقي',
              value: '${goal.remainingSubGoalsCount}',
              color: goal.remainingSubGoalsCount > 0
                  ? (isFinished ? AppColors.completed : AppColors.brass)
                  : AppColors.completed,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 13, color: color),
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: AppTypography.label.copyWith(
                fontSize: 11,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: AppTypography.ledgerNumber.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
      ],
    );
  }
}
