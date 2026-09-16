import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goals/core/app_colors.dart';
import 'package:goals/core/app_typography.dart';
import 'package:goals/view_models/home_dashboard_viewmodel.dart';

class StatusFilterTabs extends StatelessWidget {
  final GoalStatusFilter selectedStatus;
  final int inProgressCount;
  final int completedCount;
  final ValueChanged<GoalStatusFilter> onStatusChanged;

  const StatusFilterTabs({
    super.key,
    required this.selectedStatus,
    required this.inProgressCount,
    required this.completedCount,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatusTab(
              title: 'قيد التنفيذ',
              count: inProgressCount,
              isSelected: selectedStatus == GoalStatusFilter.inProgress,
              activeColor: AppColors.ink,
              onTap: () {
                HapticFeedback.selectionClick();
                onStatusChanged(GoalStatusFilter.inProgress);
              },
            ),
          ),

          const SizedBox(width: 4),

          Expanded(
            child: _buildStatusTab(
              title: 'المنجزة',
              count: completedCount,
              isSelected: selectedStatus == GoalStatusFilter.completed,
              activeColor: AppColors.completed,
              onTap: () {
                HapticFeedback.selectionClick();
                onStatusChanged(GoalStatusFilter.completed);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTab({
    required String title,
    required int count,
    required bool isSelected,
    required Color activeColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected ? activeColor : AppColors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: activeColor.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: AppTypography.headline.copyWith(
                  color: isSelected ? AppColors.white : AppColors.textSecondary,
                  fontSize: 12.5,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.white.withValues(alpha: 0.22)
                      : AppColors.background,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$count',
                  style: AppTypography.ledgerNumber.copyWith(
                    color: isSelected ? AppColors.white : AppColors.textMain,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
