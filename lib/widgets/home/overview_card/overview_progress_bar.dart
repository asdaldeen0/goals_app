import 'package:flutter/material.dart';
import 'package:goals/core/app_colors.dart';
import 'package:goals/core/app_typography.dart';

class OverviewProgressBar extends StatelessWidget {
  final double progressRatio;
  final String motivationalMessage;

  const OverviewProgressBar({
    super.key,
    required this.progressRatio,
    required this.motivationalMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          motivationalMessage,
          style: AppTypography.headline.copyWith(
            color: AppColors.textWhite,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 1.3,
          ),
        ),

        const SizedBox(height: 14),

        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: progressRatio),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
          builder: (context, animatedRatio, child) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: animatedRatio,
                minHeight: 7,
                backgroundColor: AppColors.white.withValues(alpha: 0.18),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.brass,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
