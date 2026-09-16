import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals/controllers/goal_controller.dart';
import 'package:goals/core/app_colors.dart';
import 'package:goals/core/services/notification_service.dart';
import 'package:goals/repositories/goal_repository.dart';
import 'package:goals/shared/dialogs/confirm_dialog.dart';
import 'package:goals/widgets/settings/edit_name_bottom_sheet.dart';

class SettingsViewModel extends GetxController {
  final GoalController _controller = Get.find<GoalController>();
  final GoalRepository _repository = GoalRepository();

  final String appVersion = '1.0.0';
  final String appName = 'أهدافي';
  final String appDescription =
      'تطبيق ذكي لإدارة وتتبع الأهداف الشخصية والمهام الفرعية بخطوات واضحة وإحصائيات دقيقة.';
  final String developerName = 'أسد الدين';

  RxString get userName => _controller.userName;
  int get totalGoalsCount => _controller.totalGoalsCount;
  int get completedGoalsCount => _controller.completedGoalsCount;
  int get inProgressGoalsCount => _controller.pendingGoalsCount;

  late final TextEditingController nameInputController;
  final RxString nameErrorText = ''.obs;
  final RxBool isNotificationsEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
    nameInputController = TextEditingController(text: userName.value);
    isNotificationsEnabled.value = _repository.loadNotificationsEnabled();
    
    if (isNotificationsEnabled.value) {
      NotificationService.scheduleDailyReminder();
    }
  }

  @override
  void onClose() {
    nameInputController.dispose();
    super.onClose();
  }

  void prepareEditName() {
    nameInputController.text = userName.value;
    nameErrorText.value = '';
  }

  Future<void> saveNewName() async {
    final trimmed = nameInputController.text.trim();
    if (trimmed.isEmpty) {
      nameErrorText.value = 'يرجى إدخال اسم صحيح';
      return;
    }

    await _controller.updateUserName(trimmed);
    
    if (isNotificationsEnabled.value) {
      await NotificationService.scheduleDailyReminder();
    }
    
    Get.back();

    Get.snackbar(
      'تم بنجاح',
      'تم تغيير الاسم بنجاح',
      backgroundColor: AppColors.completed.withValues(alpha: 0.15),
      colorText: AppColors.completed,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 14,
      icon: const Icon(
        Icons.check_circle_rounded,
        color: AppColors.completed,
        size: 22,
      ),
    );
  }

  void showEditNameSheet(BuildContext context) {
    prepareEditName();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EditNameBottomSheet(vm: this),
    );
  }

  Future<void> toggleNotifications(bool value) async {
    if (value) {
      final bool granted = await NotificationService.requestPermissions();
      isNotificationsEnabled.value = true;
      await _repository.saveNotificationsEnabled(true);
      await NotificationService.scheduleDailyReminder();

      Get.snackbar(
        'التذكيرات اليومية',
        granted
            ? 'تم تفعيل التذكير اليومي للأهداف (8:30 مساءً)'
            : 'تم التفعيل! تأكد من إعطاء إذن الإشعارات من إعدادات جهازك.',
        backgroundColor: AppColors.ink.withValues(alpha: 0.1),
        colorText: AppColors.ink,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
        borderRadius: 14,
        icon: const Icon(
          Icons.notifications_active_rounded,
          color: AppColors.ink,
          size: 22,
        ),
      );
    } else {
      isNotificationsEnabled.value = false;
      await _repository.saveNotificationsEnabled(false);
      await NotificationService.cancelDailyReminder();

      Get.snackbar(
        'التذكيرات اليومية',
        'تم تعطيل التذكيرات اليومية',
        backgroundColor: AppColors.seal.withValues(alpha: 0.1),
        colorText: AppColors.seal,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16),
        borderRadius: 14,
        icon: const Icon(
          Icons.notifications_off_rounded,
          color: AppColors.seal,
          size: 22,
        ),
      );
    }
  }

  void confirmClearAllData() {
    AppDialogs.showConfirmDelete(
      title: 'مسح كافة البيانات',
      message:
          'هل أنت متأكد من رغبتك في حذف جميع الأهداف نهائياً؟ لا يمكن التراجع عن هذا الإجراء.',
      onConfirm: () async {
        await _controller.clearAllGoals();
      },
    );
  }

  void goBack() => Get.back();
}
