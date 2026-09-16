import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../models/goal_model.dart';
import '../repositories/goal_repository.dart';

class GoalController extends GetxController {
  final GoalRepository _repository = GoalRepository();
  static const _uuid = Uuid();

  var goals = <GoalModel>[].obs;
  var isLoading = true.obs;
  var userName = 'بطل'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchGoals();
    fetchUserName();
  }

  int get totalGoalsCount => goals.length;

  int get completedGoalsCount => goals.where((g) => g.isCompleted).length;

  int get pendingGoalsCount => goals.where((g) => !g.isCompleted).length;

  double get overallProgressRatio =>
      goals.isEmpty ? 0.0 : completedGoalsCount / goals.length;

  List<GoalModel> get completedGoals =>
      goals.where((g) => g.isCompleted).toList();

  List<GoalModel> get pendingGoals =>
      goals.where((g) => !g.isCompleted).toList();

  void fetchUserName() {
    userName.value = _repository.loadUserName();
  }

  Future<void> updateUserName(String newName) async {
    if (newName.trim().isNotEmpty) {
      userName.value = newName.trim();
      await _repository.saveUserName(userName.value);
    }
  }

  Future<void> fetchGoals() async {
    try {
      isLoading.value = true;
      final loadedGoals = _repository.loadGoals();

      loadedGoals.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      goals.value = loadedGoals;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addGoal({
    required String title,
    required String category,
    required DateTime startDate,
    required DateTime endDate,
    required List<String> subGoalTitles,
  }) async {
    final now = DateTime.now();

    final List<SubGoalModel> subGoalsList = subGoalTitles
        .map((subTitle) => SubGoalModel(id: _uuid.v4(), title: subTitle))
        .toList();

    final newGoal = GoalModel(
      id: _uuid.v4(),
      title: title,
      category: category,
      startDate: startDate,
      endDate: endDate,
      createdAt: now,
      subGoals: subGoalsList,
    );

    goals.insert(0, newGoal);
    await _repository.saveGoals(goals);
    HapticFeedback.lightImpact();
    return true;
  }

  Future<void> deleteGoal(String id) async {
    goals.removeWhere((goal) => goal.id == id);
    await _repository.saveGoals(goals);
    HapticFeedback.mediumImpact();
  }

  Future<void> clearAllGoals() async {
    goals.clear();
    await _repository.clearGoals();
    HapticFeedback.mediumImpact();
  }

  Future<bool> updateGoal({
    required String id,
    required String title,
    required String category,
    required DateTime startDate,
    required DateTime endDate,
    required List<String> subGoalTitles,
    required List<SubGoalModel> existingSubGoals,
  }) async {
    final index = goals.indexWhere((g) => g.id == id);
    if (index == -1) return false;

    final List<SubGoalModel> updatedSubGoals = [];

    for (int i = 0; i < subGoalTitles.length; i++) {
      final text = subGoalTitles[i];
      final bool wasCompleted = i < existingSubGoals.length
          ? existingSubGoals[i].isCompleted
          : false;
      final String subId = i < existingSubGoals.length
          ? existingSubGoals[i].id
          : _uuid.v4();

      updatedSubGoals.add(
        SubGoalModel(id: subId, title: text, isCompleted: wasCompleted),
      );
    }

    goals[index].title = title;
    goals[index].category = category;
    goals[index].startDate = startDate;
    goals[index].endDate = endDate;
    goals[index].subGoals = updatedSubGoals;

    goals.refresh();
    await _repository.saveGoals(goals);
    HapticFeedback.lightImpact();
    return true;
  }

  Future<void> toggleSubGoalStatus(String goalId, String subGoalId) async {
    final goalIndex = goals.indexWhere((g) => g.id == goalId);
    if (goalIndex == -1) return;

    final subIndex = goals[goalIndex].subGoals.indexWhere(
      (s) => s.id == subGoalId,
    );
    if (subIndex == -1) return;

    final bool isNowCompleted = !goals[goalIndex].subGoals[subIndex].isCompleted;
    goals[goalIndex].subGoals[subIndex].isCompleted = isNowCompleted;

    if (isNowCompleted) {
      if (goals[goalIndex].isCompleted) {
        HapticFeedback.heavyImpact();
      } else {
        HapticFeedback.mediumImpact();
      }
    } else {
      HapticFeedback.lightImpact();
    }

    goals.refresh();
    await _repository.saveGoals(goals);
  }

  double get overallSubGoalsProgress {
    if (goals.isEmpty) return 0.0;

    final totalSubGoals = goals.fold<int>(
      0,
      (sum, goal) => sum + goal.subGoals.length,
    );

    if (totalSubGoals == 0) return 0.0;

    final completedSubGoals = goals.fold<int>(
      0,
      (sum, goal) => sum + goal.completedSubGoalsCount,
    );

    return completedSubGoals / totalSubGoals;
  }
}
