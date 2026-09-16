import 'package:flutter/material.dart';
import 'package:goals/view_models/home_dashboard_viewmodel.dart';
import 'category_filter_button.dart';
import 'status_filter_tabs.dart';

class GoalsFilterBar extends StatelessWidget {
  final GoalStatusFilter selectedStatus;
  final int inProgressCount;
  final int completedCount;
  final String selectedCategory;
  final List<String> availableCategories;
  final ValueChanged<GoalStatusFilter> onStatusChanged;
  final ValueChanged<String> onCategorySelected;
  final VoidCallback onClearCategory;

  const GoalsFilterBar({
    super.key,
    required this.selectedStatus,
    required this.inProgressCount,
    required this.completedCount,
    required this.selectedCategory,
    required this.availableCategories,
    required this.onStatusChanged,
    required this.onCategorySelected,
    required this.onClearCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatusFilterTabs(
            selectedStatus: selectedStatus,
            inProgressCount: inProgressCount,
            completedCount: completedCount,
            onStatusChanged: onStatusChanged,
          ),
        ),

        const SizedBox(width: 10),

        CategoryFilterButton(
          selectedCategory: selectedCategory,
          availableCategories: availableCategories,
          onCategorySelected: onCategorySelected,
          onClearCategory: onClearCategory,
        ),
      ],
    );
  }
}
