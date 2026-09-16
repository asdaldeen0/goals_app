import 'package:get/get.dart';
import 'package:goals/controllers/goal_controller.dart';
import 'package:goals/core/utils/date_formatter.dart';
import 'package:goals/models/goal_model.dart';

class GoalDetailsViewModel extends GetxController {
  final GoalController _goalController = Get.find<GoalController>();

  final GoalModel initialGoal = Get.arguments as GoalModel;

  GoalModel get goal => _goalController.goals.firstWhere(
    (g) => g.id == initialGoal.id,
    orElse: () => initialGoal,
  );

  int get totalSubGoals => goal.subGoals.length;
  int get completedSubGoals => goal.subGoals.where((s) => s.isCompleted).length;
  double get progressRatio => goal.progressRatio;
  String get progressPercentage => '${(progressRatio * 100).toInt()}%';

  String get dateRangeText =>
      AppDateFormatter.formatRange(goal.startDate, goal.endDate);

  Future<void> toggleSubGoal(String subGoalId) async {
    await _goalController.toggleSubGoalStatus(goal.id, subGoalId);
  }
}
