import 'package:get/get.dart';
import 'package:goals/controllers/goal_controller.dart';
import 'package:goals/core/app_categories.dart';
import 'package:goals/core/utils/date_formatter.dart';
import 'package:goals/models/goal_model.dart';
import 'package:goals/view/add_goal_view.dart';
import 'package:goals/view/goal_details_view.dart';

enum GoalStatusFilter { inProgress, completed }

class HomeDashboardViewModel extends GetxController {
  final GoalController _controller = Get.find<GoalController>();

  RxString get userName => _controller.userName;
  RxList<GoalModel> get goals => _controller.goals;
  RxBool get isLoading => _controller.isLoading;

  int get totalGoalsCount => _controller.totalGoalsCount;
  int get completedGoalsCount => _controller.completedGoalsCount;
  int get inProgressGoalsCount => _controller.pendingGoalsCount;

  final String floatingActionText = 'إضافة هدف';

  final String welcomeSubtitle = 'مستعد لإنجازات اليوم؟';

  String get timeGreeting {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return 'صباح الخير، يا ${userName.value}';
    } else if (hour >= 12 && hour < 17) {
      return 'طاب مساؤك، يا ${userName.value}';
    } else {
      return 'مساء الخير، يا ${userName.value}';
    }
  }

  String get todayDateText => AppDateFormatter.getTodayFormatted();

  final Rx<GoalStatusFilter> selectedStatusFilter =
      GoalStatusFilter.inProgress.obs;

  final RxString selectedCategoryFilter = 'الكل'.obs;

  List<String> get availableCategories => [
    'الكل',
    ...AppCategories.list.map((c) => c['name'] as String),
  ];

  List<GoalModel> get filteredGoals {
    List<GoalModel> list =
        selectedStatusFilter.value == GoalStatusFilter.completed
        ? _controller.completedGoals
        : _controller.pendingGoals;

    if (selectedCategoryFilter.value != 'الكل') {
      list = list
          .where((g) => g.category == selectedCategoryFilter.value)
          .toList();
    }

    return list;
  }

  void setStatusFilter(GoalStatusFilter filter) {
    selectedStatusFilter.value = filter;
  }

  void setCategoryFilter(String category) {
    selectedCategoryFilter.value = category;
  }

  void clearCategoryFilter() {
    selectedCategoryFilter.value = 'الكل';
  }

  String get emptyStateTitle {
    if (goals.isEmpty) {
      return 'لا توجد أهداف مضافة حتى الآن';
    }
    if (selectedCategoryFilter.value != 'الكل') {
      return selectedStatusFilter.value == GoalStatusFilter.completed
          ? 'لا توجد أهداف منجزة في تصنيف "${selectedCategoryFilter.value}"'
          : 'لا توجد أهداف قيد التنفيذ في تصنيف "${selectedCategoryFilter.value}"';
    }
    return selectedStatusFilter.value == GoalStatusFilter.completed
        ? 'لا توجد أهداف مكتملة حتى الآن'
        : 'لا توجد أهداف قيد التنفيذ حالياً';
  }

  String get emptyStateSubtitle {
    if (goals.isEmpty) {
      return 'اضغط على زر "إضافة هدف" لتبدأ رحلتك!';
    }
    if (selectedStatusFilter.value == GoalStatusFilter.completed) {
      return 'أنجز مهام أهدافك الجارية لتراها هنا!';
    }
    return 'رائع! أنجزت كافة أهدافك الحالية بنجاح.';
  }


  double get overallProgress => _controller.overallProgressRatio;
  int get overallProgressPercentage => (overallProgress * 100).toInt();

  String get motivationalMessage {
    if (totalGoalsCount == 0) {
      return 'ابدأ رحلتك وحدد أول أهدافك لليوم';
    } else if (overallProgress >= 1.0) {
      return 'أداء استثنائي، حققت خطتك بالكامل';
    } else if (overallProgress >= 0.75) {
      return 'أنت قريب جداً من إتمام جميع أهدافك';
    } else if (overallProgress >= 0.50) {
      return 'أنجزت أكثر من نصف مهامك، واصل التقدم';
    } else if (overallProgress > 0.0) {
      return 'بداية ممتازة، استمر في تحقيق خطواتك';
    } else {
      return 'استعد للانطلاق وأنجز أولى خطواتك';
    }
  }

  String formatDateRange(DateTime start, DateTime end) {
    return AppDateFormatter.formatRange(start, end);
  }


  void goToEditGoal(GoalModel goal) {
    Get.to(() => const AddGoalView(), arguments: goal);
  }

  void goToGoalDetails(GoalModel goal) {
    Get.to(() => const GoalDetailsView(), arguments: goal);
  }

  void goToAddGoal() => Get.to(() => const AddGoalView());

  Future<void> refreshGoals() async => await _controller.fetchGoals();

  Future<void> deleteGoal(String id) async => await _controller.deleteGoal(id);

  void updateUserName(String newName) => _controller.updateUserName(newName);
}
