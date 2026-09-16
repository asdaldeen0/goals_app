import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals/core/app_colors.dart';
import 'package:goals/models/goal_model.dart';
import 'package:goals/shared/dialogs/confirm_dialog.dart';
import 'package:goals/view_models/home_dashboard_viewmodel.dart';
import 'package:goals/widgets/home/drawer/app_drawer.dart';
import 'package:goals/widgets/home/filter_bar/goals_filter_bar.dart';
import 'package:goals/widgets/home/goal_card/goal_card.dart';
import 'package:goals/widgets/home/home_add_goal_fab.dart';
import 'package:goals/widgets/home/home_empty_state.dart';
import 'package:goals/widgets/home/overview_card/in_progress_overview_card.dart';
import 'package:goals/widgets/home/welcome_home.dart';

class HomeDashboardView extends StatelessWidget {
  HomeDashboardView({super.key});

  final HomeDashboardViewModel _viewModel = Get.put(HomeDashboardViewModel());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.background,
        drawer: const AppDrawer(),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: HomeAddGoalFab(
          label: _viewModel.floatingActionText,
          onPressed: _viewModel.goToAddGoal,
        ),
        body: SafeArea(
          child: RefreshIndicator(
            color: AppColors.ink,
            onRefresh: _viewModel.refreshGoals,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => WelcomeHome(
                      greeting: _viewModel.timeGreeting,
                      subtitle: _viewModel.welcomeSubtitle,
                      dateText: _viewModel.todayDateText,
                      onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Obx(
                    () => InProgressOverviewCard(
                      percentage: _viewModel.overallProgressPercentage,
                      motivationalMessage: _viewModel.motivationalMessage,
                      progressRatio: _viewModel.overallProgress,
                      inProgressCount: _viewModel.inProgressGoalsCount,
                      completedCount: _viewModel.completedGoalsCount,
                      totalCount: _viewModel.totalGoalsCount,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Obx(
                    () => GoalsFilterBar(
                      selectedStatus: _viewModel.selectedStatusFilter.value,
                      inProgressCount: _viewModel.inProgressGoalsCount,
                      completedCount: _viewModel.completedGoalsCount,
                      selectedCategory: _viewModel.selectedCategoryFilter.value,
                      availableCategories: _viewModel.availableCategories,
                      onStatusChanged: _viewModel.setStatusFilter,
                      onCategorySelected: _viewModel.setCategoryFilter,
                      onClearCategory: _viewModel.clearCategoryFilter,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Obx(() {
                    if (_viewModel.isLoading.value) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.ink,
                          ),
                        ),
                      );
                    }

                    final goals = _viewModel.filteredGoals;

                    if (goals.isEmpty) {
                      return HomeEmptyState(
                        icon:
                            _viewModel.selectedStatusFilter.value ==
                                GoalStatusFilter.completed
                            ? Icons.task_alt_rounded
                            : Icons.flag_outlined,
                        title: _viewModel.emptyStateTitle,
                        subtitle: _viewModel.emptyStateSubtitle,
                      );
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: goals.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final GoalModel goal = goals[index];

                        return GoalCard(
                          title: goal.title,
                          category: goal.category,
                          dateRange: _viewModel.formatDateRange(
                            goal.startDate,
                            goal.endDate,
                          ),
                          remainingDays: goal.remainingDays,
                          completedSubGoals: goal.completedSubGoalsCount,
                          totalSubGoals: goal.subGoals.length,
                          progressRatio: goal.progressRatio,
                          isCompleted: goal.isCompleted,
                          onTap: () => _viewModel.goToGoalDetails(goal),
                          onEdit: () => _viewModel.goToEditGoal(goal),
                          onDelete: () => AppDialogs.showConfirmDelete(
                            title: 'تأكيد الحذف',
                            message: 'هل أنت متأكد من حذف هدف "${goal.title}"؟',
                            onConfirm: () => _viewModel.deleteGoal(goal.id),
                          ),
                        );
                      },
                    );
                  }),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
