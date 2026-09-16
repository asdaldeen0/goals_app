import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goals/core/app_categories.dart';
import 'package:goals/core/app_colors.dart';
import 'package:goals/core/app_typography.dart';

class CategoryFilterButton extends StatelessWidget {
  final String selectedCategory;
  final List<String> availableCategories;
  final ValueChanged<String> onCategorySelected;
  final VoidCallback onClearCategory;

  const CategoryFilterButton({
    super.key,
    required this.selectedCategory,
    required this.availableCategories,
    required this.onCategorySelected,
    required this.onClearCategory,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCategoryFiltered = selectedCategory != 'الكل';
    final Color activeCategoryColor = isCategoryFiltered
        ? AppCategories.getColor(selectedCategory)
        : AppColors.ink;

    return PopupMenuButton<String>(
      tooltip: 'تصفية حسب التصنيف',
      initialValue: selectedCategory,
      onSelected: (String category) {
        HapticFeedback.selectionClick();
        if (category == selectedCategory && isCategoryFiltered) {
          onClearCategory();
        } else {
          onCategorySelected(category);
        }
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: AppColors.border),
      ),
      color: AppColors.cardSurface,
      elevation: 6,
      offset: const Offset(0, 48),
      itemBuilder: (BuildContext context) {
        return availableCategories.map((String cat) {
          final bool isAll = cat == 'الكل';
          final Color catColor =
              isAll ? AppColors.ink : AppCategories.getColor(cat);
          final IconData catIcon =
              isAll ? Icons.grid_view_rounded : AppCategories.getIcon(cat);
          final bool isSelected = selectedCategory == cat;

          return PopupMenuItem<String>(
            value: cat,
            height: 44,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: catColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(catIcon, size: 14, color: catColor),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    cat,
                    style: AppTypography.body.copyWith(
                      fontSize: 13,
                      fontWeight:
                          isSelected ? FontWeight.w800 : FontWeight.w600,
                      color: isSelected ? catColor : AppColors.textMain,
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_rounded,
                    size: 16,
                    color: catColor,
                  ),
              ],
            ),
          );
        }).toList();
      },
      child: Container(
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isCategoryFiltered
              ? activeCategoryColor.withValues(alpha: 0.12)
              : AppColors.cardSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isCategoryFiltered
                ? activeCategoryColor.withValues(alpha: 0.4)
                : AppColors.border,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isCategoryFiltered
                  ? AppCategories.getIcon(selectedCategory)
                  : Icons.tune_rounded,
              size: 18,
              color: isCategoryFiltered
                  ? activeCategoryColor
                  : AppColors.textSecondary,
            ),
            if (isCategoryFiltered) ...[
              const SizedBox(width: 6),
              Text(
                selectedCategory,
                style: AppTypography.label.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: activeCategoryColor,
                ),
              ),
              const SizedBox(width: 4),
              InkWell(
                onTap: onClearCategory,
                borderRadius: BorderRadius.circular(10),
                child: Icon(
                  Icons.close_rounded,
                  size: 15,
                  color: activeCategoryColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
