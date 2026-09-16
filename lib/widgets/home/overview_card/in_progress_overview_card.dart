import 'package:flutter/material.dart';
import 'package:goals/core/app_colors.dart';
import 'overview_header.dart';
import 'overview_metrics_bar.dart';
import 'overview_progress_bar.dart';

class InProgressOverviewCard extends StatelessWidget {
  final int percentage;
  final String motivationalMessage;
  final double progressRatio;
  final int inProgressCount;
  final int completedCount;
  final int totalCount;

  const InProgressOverviewCard({
    super.key,
    required this.percentage,
    required this.motivationalMessage,
    required this.progressRatio,
    required this.inProgressCount,
    required this.completedCount,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.ink, AppColors.inkDark],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.ink.withValues(alpha: 0.28),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Positioned(
              left: -20,
              top: -20,
              child: Icon(
                Icons.insights_rounded,
                size: 130,
                color: AppColors.white.withValues(alpha: 0.05),
              ),
            ),
            Positioned(
              right: -30,
              bottom: -30,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white.withValues(alpha: 0.03),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OverviewHeader(percentage: percentage),
                  const SizedBox(height: 16),
                  OverviewProgressBar(
                    progressRatio: progressRatio,
                    motivationalMessage: motivationalMessage,
                  ),
                  const SizedBox(height: 18),
                  OverviewMetricsBar(
                    inProgressCount: inProgressCount,
                    completedCount: completedCount,
                    totalCount: totalCount,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
