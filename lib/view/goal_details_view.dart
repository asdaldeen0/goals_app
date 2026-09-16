import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals/core/app_typography.dart';
import 'package:goals/view_models/goal_details_viewmodel.dart';
import 'package:goals/widgets/details/appbar_details.dart';
import 'package:goals/widgets/details/card_hero_details.dart';
import '../core/app_colors.dart';

class GoalDetailsView extends StatelessWidget {
  const GoalDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final GoalDetailsViewModel vm = Get.put(GoalDetailsViewModel());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const GoalDetailsAppBar(),
      body: Obx(() {
        final goal = vm.goal;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GoalHeroDashboardCard(goal: goal, vm: vm),
              const SizedBox(height: 28),

              Text(
                'الخطوات والمهام التنفيذية',
                style: AppTypography.headline.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textMain,
                ),
              ),
              const SizedBox(height: 14),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: goal.subGoals.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final sub = goal.subGoals[index];

                  return InkWell(
                    onTap: () => vm.toggleSubGoal(sub.id),
                    borderRadius: BorderRadius.circular(16),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: sub.isCompleted
                            ? AppColors.cardSurface.withValues(alpha: 0.6)
                            : AppColors.cardSurface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: sub.isCompleted
                              ? AppColors.completed.withValues(alpha: 0.4)
                              : AppColors.border,
                        ),
                      ),
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: sub.isCompleted
                                  ? AppColors.completed
                                  : AppColors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: sub.isCompleted
                                    ? AppColors.completed
                                    : AppColors.border,
                                width: 2,
                              ),
                            ),
                            child: sub.isCompleted
                                ? const Icon(
                                    Icons.check_rounded,
                                    size: 16,
                                    color: AppColors.white,
                                  )
                                : null,
                          ),
                          const SizedBox(width: 14),

                          Expanded(
                            child: Text(
                              sub.title,
                              style: AppTypography.body.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                decoration: sub.isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: sub.isCompleted
                                    ? AppColors.textSecondary
                                    : AppColors.textMain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
