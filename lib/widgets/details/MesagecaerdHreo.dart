
import 'package:flutter/material.dart';
import 'package:goals/core/app_colors.dart';
import 'package:goals/core/app_typography.dart';

class Mesage_caerdHreo extends StatelessWidget {
  const Mesage_caerdHreo({
    super.key,
    required this.isFinished,
    required this.accentColor,
    required this.progressRatio,
  });

  final bool isFinished;
  final Color accentColor;
  final double progressRatio;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isFinished
                    ? Icons.stars_rounded
                    : Icons.trending_up_rounded,
                size: 16,
                color: accentColor,
              ),
              const SizedBox(width: 6),
              Text(
                'مستوى التقدم',
                style: AppTypography.label.copyWith(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            isFinished
                ? 'تهانينا! حققت جميع خطوات هذا الهدف بالكامل'
                : progressRatio > 0.0
                    ? 'استمر، أنت تحقق تقدماً رائعاً نحو هدفك'
                    : 'ابدأ بإنجاز أول خطوة اليوم',
            style: AppTypography.bodySecondary.copyWith(
              fontSize: 12.5,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
