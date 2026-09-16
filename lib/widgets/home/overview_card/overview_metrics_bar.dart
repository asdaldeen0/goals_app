import 'package:flutter/material.dart';
import 'package:goals/core/app_colors.dart';
import 'package:goals/core/app_typography.dart';

class OverviewMetricsBar extends StatelessWidget {
  final int inProgressCount;
  final int completedCount;
  final int totalCount;

  const OverviewMetricsBar({
    super.key,
    required this.inProgressCount,
    required this.completedCount,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildMetricItem(
              label: 'قيد التنفيذ',
              value: '$inProgressCount',
              icon: Icons.pending_actions_rounded,
              iconColor: AppColors.brass,
            ),
          ),
          Container(
            width: 1,
            height: 28,
            color: AppColors.white.withValues(alpha: 0.15),
          ),
          Expanded(
            child: _buildMetricItem(
              label: 'المكتملة',
              value: '$completedCount',
              icon: Icons.task_alt_rounded,
              iconColor: AppColors.completed,
            ),
          ),
          Container(
            width: 1,
            height: 28,
            color: AppColors.white.withValues(alpha: 0.15),
          ),
          Expanded(
            child: _buildMetricItem(
              label: 'الإجمالي',
              value: '$totalCount',
              icon: Icons.format_list_bulleted_rounded,
              iconColor: AppColors.textWhite70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem({
    required String label,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 12, color: iconColor),
            const SizedBox(width: 4),
            Text(
              label,
              style: AppTypography.label.copyWith(
                color: AppColors.textWhite.withValues(alpha: 0.8),
                fontSize: 10.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTypography.ledgerNumber.copyWith(
            color: AppColors.textWhite,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
