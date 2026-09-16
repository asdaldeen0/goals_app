import 'package:flutter_test/flutter_test.dart';
import 'package:goals/models/goal_model.dart';

void main() {
  group('GoalModel Tests', () {
    test('GoalModel calculation and progress ratio work correctly', () {
      final now = DateTime.now();
      final subGoals = [
        SubGoalModel(id: '1', title: 'Step 1', isCompleted: true),
        SubGoalModel(id: '2', title: 'Step 2', isCompleted: false),
      ];

      final goal = GoalModel(
        id: 'goal_1',
        title: 'Learn Flutter',
        category: 'التعلم والتطوير',
        startDate: now,
        endDate: now.add(const Duration(days: 30)),
        createdAt: now,
        subGoals: subGoals,
      );

      expect(goal.completedSubGoalsCount, 1);
      expect(goal.progressRatio, 0.5);
      expect(goal.isCompleted, false);
      expect(goal.remainingDays, 30);
    });

    test('GoalModel serialization toMap and fromMap works seamlessly', () {
      final now = DateTime.now();
      final original = GoalModel(
        id: 'goal_2',
        title: 'Gym workout',
        category: 'الصحة واللياقة',
        startDate: now,
        endDate: now.add(const Duration(days: 10)),
        createdAt: now,
        subGoals: [
          SubGoalModel(id: 'sub_1', title: 'Leg day', isCompleted: true),
        ],
      );

      final map = original.toMap();
      final reconstructed = GoalModel.fromMap(map);

      expect(reconstructed.id, original.id);
      expect(reconstructed.title, original.title);
      expect(reconstructed.category, original.category);
      expect(reconstructed.subGoals.length, 1);
      expect(reconstructed.subGoals.first.title, 'Leg day');
      expect(reconstructed.subGoals.first.isCompleted, true);
    });
  });
}
