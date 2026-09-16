import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppCategories {
  static const List<Map<String, dynamic>> list = [
    {
      'name': 'عمل',
      'color': AppColors.workCategory,
      'icon': Icons.work_outline_rounded,
    },
    {
      'name': 'دراسة',
      'color': AppColors.studyCategory,
      'icon': Icons.menu_book_rounded,
    },
    {
      'name': 'رياضة',
      'color': AppColors.sportCategory,
      'icon': Icons.fitness_center_rounded,
    },
    {
      'name': 'صحة',
      'color': AppColors.healthCategory,
      'icon': Icons.favorite_border_rounded,
    },
    {
      'name': 'مالي',
      'color': AppColors.financeCategory,
      'icon': Icons.account_balance_wallet_outlined,
    },
    {
      'name': 'شخصي',
      'color': AppColors.personalCategory,
      'icon': Icons.person_outline_rounded,
    },
    {
      'name': 'عام',
      'color': AppColors.defaultCategory,
      'icon': Icons.layers_outlined,
    },
  ];

  static Color getColor(String categoryName) {
    final cat = categoryName.trim().toLowerCase();
    for (final item in list) {
      final name = (item['name'] as String).toLowerCase();
      if (cat == name || cat.contains(name)) {
        return item['color'] as Color;
      }
    }
    if (cat.contains('sport')) return AppColors.sportCategory;
    if (cat.contains('study')) return AppColors.studyCategory;
    if (cat.contains('work')) return AppColors.workCategory;
    if (cat.contains('health')) return AppColors.healthCategory;
    if (cat.contains('finance') || cat.contains('money')) {
      return AppColors.financeCategory;
    }
    if (cat.contains('personal')) return AppColors.personalCategory;

    return AppColors.ink;
  }

  static IconData getIcon(String categoryName) {
    final cat = categoryName.trim().toLowerCase();
    for (final item in list) {
      final name = (item['name'] as String).toLowerCase();
      if (cat == name || cat.contains(name)) {
        return item['icon'] as IconData;
      }
    }
    if (cat.contains('sport')) return Icons.fitness_center_rounded;
    if (cat.contains('study')) return Icons.menu_book_rounded;
    if (cat.contains('work')) return Icons.work_outline_rounded;
    if (cat.contains('health')) return Icons.favorite_border_rounded;
    if (cat.contains('finance') || cat.contains('money')) {
      return Icons.account_balance_wallet_outlined;
    }
    if (cat.contains('personal')) return Icons.person_outline_rounded;

    return Icons.label_rounded;
  }
}
