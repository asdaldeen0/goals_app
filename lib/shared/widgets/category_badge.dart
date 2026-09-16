import 'package:flutter/material.dart';
import 'package:goals/core/app_categories.dart';
import 'package:goals/core/app_typography.dart';

class CategoryBadge extends StatelessWidget {
  final String category;

  const CategoryBadge({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final Color categoryColor = AppCategories.getColor(category);
    final IconData categoryIcon = AppCategories.getIcon(category);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: categoryColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(categoryIcon, size: 13, color: categoryColor),
          const SizedBox(width: 5),
          Text(
            category,
            style: AppTypography.label.copyWith(
              color: categoryColor,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
