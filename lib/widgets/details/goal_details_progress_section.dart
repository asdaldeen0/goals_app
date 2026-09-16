import 'package:flutter/material.dart';
import 'package:goals/widgets/details/MesagecaerdHreo.dart';
import '../../core/app_colors.dart';
import '../../core/app_typography.dart';

class GoalDetailsProgressSection extends StatelessWidget {
  final double progressRatio;
  final bool isFinished;
  final Color accentColor;

  const GoalDetailsProgressSection({
    super.key,
    required this.progressRatio,
    required this.isFinished,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: progressRatio),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutCubic,
            builder: (context, animatedRatio, child) {
              final int percent = (animatedRatio * 100).toInt();

              return SizedBox(
                width: 84,
                height: 84,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 84,
                      height: 84,
                      child: CircularProgressIndicator(
                        value: 1.0,
                        strokeWidth: 8,
                        backgroundColor: AppColors.transparent,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          accentColor.withValues(alpha: 0.12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 84,
                      height: 84,
                      child: CircularProgressIndicator(
                        value: animatedRatio,
                        strokeWidth: 8,
                        strokeCap: StrokeCap.round,
                        backgroundColor: AppColors.transparent,
                        valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                      ),
                    ),

                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$percent%',
                          style: AppTypography.ledgerNumber.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                            color: AppColors.textMain,
                            height: 1.1,
                          ),
                        ),
                        Text(
                          'إنجاز',
                          style: AppTypography.label.copyWith(
                            fontSize: 10,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(width: 18),

          Mesage_caerdHreo(
            isFinished: isFinished,
            accentColor: accentColor,
            progressRatio: progressRatio,
          ),
        ],
      ),
    );
  }
}
