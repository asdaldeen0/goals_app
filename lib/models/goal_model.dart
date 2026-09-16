import 'dart:convert';

class SubGoalModel {
  final String id;
  String title;
  bool isCompleted;

  SubGoalModel({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'isCompleted': isCompleted};
  }

  factory SubGoalModel.fromMap(Map<String, dynamic> map) {
    return SubGoalModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
    );
  }
}

class GoalModel {
  final String id;
  String title;
  String category;
  DateTime startDate;
  DateTime endDate;
  final DateTime createdAt;
  List<SubGoalModel> subGoals;

  GoalModel({
    required this.id,
    required this.title,
    required this.category,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.subGoals,
  });

  int get completedSubGoalsCount =>
      subGoals.where((sub) => sub.isCompleted).length;

  int get remainingSubGoalsCount => subGoals.length - completedSubGoalsCount;

  double get progressRatio =>
      subGoals.isEmpty ? 0.0 : completedSubGoalsCount / subGoals.length;

  int get progressPercentage => (progressRatio * 100).toInt();

  bool get isCompleted =>
      subGoals.isNotEmpty && completedSubGoalsCount == subGoals.length;

  int get remainingDays {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final end = DateTime(endDate.year, endDate.month, endDate.day);
    final difference = end.difference(today).inDays;
    return difference > 0 ? difference : 0;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'subGoals': subGoals.map((sub) => sub.toMap()).toList(),
    };
  }

  factory GoalModel.fromMap(Map<String, dynamic> map) {
    return GoalModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      category: map['category'] ?? 'عام',
      startDate: map['startDate'] != null
          ? DateTime.parse(map['startDate'])
          : DateTime.parse(map['createdAt']),
      endDate: map['endDate'] != null
          ? DateTime.parse(map['endDate'])
          : DateTime.parse(map['createdAt']),
      createdAt: DateTime.parse(map['createdAt']),
      subGoals:
          (map['subGoals'] as List<dynamic>?)
              ?.map(
                (subMap) =>
                    SubGoalModel.fromMap(subMap as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  String toJson() => json.encode(toMap());

  factory GoalModel.fromJson(String source) =>
      GoalModel.fromMap(json.decode(source));
}
