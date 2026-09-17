import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_typography.dart';

class DateRangeSelector extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final VoidCallback onTap;

  const DateRangeSelector({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final String startFormatted =
        '${startDate.day}/${startDate.month}/${startDate.year}';
    final String endFormatted =
        '${endDate.day}/${endDate.month}/${endDate.year}';

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Center(
          child: Text(
            '  من     \u200E$startFormatted      إلى         \u200E$endFormatted ',
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: AppTypography.ledgerNumber.copyWith(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: AppColors.textMain,
            ),
          ),
        ),
      ),
    );
  }
}
