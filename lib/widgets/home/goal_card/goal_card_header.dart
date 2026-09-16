import 'package:flutter/material.dart';
import 'package:goals/core/app_colors.dart';
import 'package:goals/shared/widgets/category_badge.dart';
import 'package:goals/shared/widgets/goal_status_badge.dart';

class GoalCardHeader extends StatelessWidget {
  final String category;
  final int remainingDays;
  final bool isCompleted;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const GoalCardHeader({
    super.key,
    required this.category,
    required this.remainingDays,
    required this.isCompleted,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CategoryBadge(category: category),
            const SizedBox(width: 8),
            GoalStatusBadge(
              remainingDays: remainingDays,
              isCompleted: isCompleted,
            ),
          ],
        ),
        Row(
          children: [
            InkResponse(
              onTap: onEdit,
              radius: 16,
              child: const Icon(
                Icons.edit_outlined,
                color: AppColors.ink,
                size: 19,
              ),
            ),
            const SizedBox(width: 14),
            InkResponse(
              onTap: onDelete,
              radius: 16,
              child: const Icon(
                Icons.delete_outline_rounded,
                color: AppColors.seal,
                size: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
