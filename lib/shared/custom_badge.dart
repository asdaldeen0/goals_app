import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_typography.dart';

class CustomBadge extends StatelessWidget {
  final String count;
  final String label;
  final Color? textColor;
  final Color? backgroundColor;

  const CustomBadge({
    super.key,
    required this.count,
    required this.label,
    this.textColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = textColor ?? AppColors.ink;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.inkWash,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        textDirection: TextDirection.rtl,
        children: [
          Text(
            count,
            style: AppTypography.ledgerNumber.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: effectiveColor,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTypography.label.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: effectiveColor,
            ),
          ),
        ],
      ),
    );
  }
}
