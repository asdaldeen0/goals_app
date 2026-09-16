import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/goal_model.dart';
import '../controllers/goal_controller.dart';
import '../core/app_colors.dart';
import '../core/app_categories.dart';
import '../core/utils/date_formatter.dart';

class AddGoalViewModel extends GetxController {
  final GoalController _goalController = Get.find<GoalController>();

  final GoalModel? goalToEdit = Get.arguments is GoalModel
      ? Get.arguments as GoalModel
      : null;

  bool get isEditing => goalToEdit != null;
  String get appBarTitle => isEditing ? 'تعديل الهدف' : 'خطة هدف جديدة';
  void appBarBackAction() => Get.back();

  final TextEditingController titleController = TextEditingController();
  final RxList<TextEditingController> subGoalsControllers =
      <TextEditingController>[].obs;

  final Rx<String?> titleError = Rx<String?>(null);
  final RxList<String?> subGoalErrors = <String?>[].obs;

  final List<Map<String, dynamic>> categories = AppCategories.list;
  final RxString selectedCategory = 'عمل'.obs;

  final Rx<DateTime> startDate = DateTime.now().obs;
  final Rx<DateTime> endDate = DateTime.now().add(const Duration(days: 14)).obs;

  int get durationInDays =>
      AppDateFormatter.calculateDurationInDays(startDate.value, endDate.value);

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  void _initializeData() {
    if (isEditing) {
      final goal = goalToEdit!;
      titleController.text = goal.title;
      selectedCategory.value = goal.category;
      startDate.value = goal.startDate;
      endDate.value = goal.endDate;

      for (final sub in goal.subGoals) {
        subGoalsControllers.add(TextEditingController(text: sub.title));
        subGoalErrors.add(null);
      }
    } else {
      addSubGoal();
      addSubGoal();
    }
  }

  void setCategory(String categoryName) =>
      selectedCategory.value = categoryName;

  void addSubGoal() {
    if (subGoalsControllers.length >= 10) {
      return _showErrorSnackbar('الحد الأقصى هو 10 أهداف فرعية');
    }
    subGoalsControllers.add(TextEditingController());
    subGoalErrors.add(null);
  }

  void removeSubGoal(int index) {
    if (subGoalsControllers.length > 2) {
      subGoalsControllers[index].dispose();
      subGoalsControllers.removeAt(index);
      subGoalErrors.removeAt(index);
    }
  }

  void clearTitleError(String value) => titleError.value = null;

  void clearSubGoalError(int index, String value) {
    if (index < subGoalErrors.length) subGoalErrors[index] = null;
  }

  Future<void> pickDateRange(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime earliestDate = startDate.value.isBefore(today)
        ? startDate.value
        : today;

    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: earliestDate,
      lastDate: DateTime(now.year + 5),
      initialDateRange: DateTimeRange(
        start: startDate.value,
        end: endDate.value.isBefore(startDate.value)
            ? startDate.value
            : endDate.value,
      ),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.ink,
              onPrimary: AppColors.white,
              surface: AppColors.cardSurface,
              onSurface: AppColors.textMain,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      startDate.value = picked.start;
      endDate.value = picked.end;
    }
  }

  Future<void> saveGoal() async {
    if (!_validateForm()) return;

    final subTitles = subGoalsControllers
        .map((c) => c.text.trim())
        .where((t) => t.isNotEmpty)
        .toList();

    bool isSuccess = isEditing
        ? await _goalController.updateGoal(
            id: goalToEdit!.id,
            title: titleController.text.trim(),
            category: selectedCategory.value,
            startDate: startDate.value,
            endDate: endDate.value,
            subGoalTitles: subTitles,
            existingSubGoals: goalToEdit!.subGoals,
          )
        : await _goalController.addGoal(
            title: titleController.text.trim(),
            category: selectedCategory.value,
            startDate: startDate.value,
            endDate: endDate.value,
            subGoalTitles: subTitles,
          );

    if (isSuccess) {
      Get.back();
      _showSuccessSnackbar();
    }
  }

  bool _validateForm() {
    bool hasError = false;
    if (titleController.text.trim().isEmpty) {
      titleError.value = 'يرجى إدخال عنوان الهدف الرئيسي';
      hasError = true;
    }

    while (subGoalsControllers.length < 2) {
      addSubGoal();
    }

    for (int i = 0; i < subGoalsControllers.length; i++) {
      if (subGoalsControllers[i].text.trim().isEmpty) {
        subGoalErrors[i] = (i == 0)
            ? 'يرجى إدخال الهدف الفرعي الأول'
            : (i == 1)
            ? 'يجب إضافة هدفين فرعيين على الأقل'
            : 'يرجى ملء الحقل أو حذفه';
        hasError = true;
      }
    }
    subGoalErrors.refresh();
    return !hasError;
  }

  void _showErrorSnackbar(String msg) {
    Get.snackbar(
      'تنبيه',
      msg,
      backgroundColor: AppColors.seal.withValues(alpha: 0.1),
      colorText: AppColors.seal,
    );
  }

  void _showSuccessSnackbar() {
    Get.snackbar(
      'تم بنجاح',
      isEditing ? 'تم تحديث خطة الهدف' : 'تمت إضافة الهدف',
      backgroundColor: AppColors.completed.withValues(alpha: 0.1),
      colorText: AppColors.completed,
    );
  }

  @override
  void onClose() {
    titleController.dispose();
    for (final c in subGoalsControllers) {
      c.dispose();
    }
    super.onClose();
  }
}
