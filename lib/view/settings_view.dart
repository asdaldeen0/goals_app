import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals/core/app_colors.dart';
import 'package:goals/core/app_typography.dart';
import 'package:goals/view/developer_view.dart';
import 'package:goals/view_models/settings_viewmodel.dart';
import 'package:goals/widgets/settings/settings_section_card.dart';
import 'package:goals/widgets/settings/settings_tile.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsViewModel viewModel = Get.put(SettingsViewModel());

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: InkWell(
              onTap: viewModel.goBack,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.cardSurface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.textMain,
                  size: 18,
                ),
              ),
            ),
          ),
          title: Text(
            'الإعدادات',
            style: AppTypography.displayMedium.copyWith(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: AppColors.textMain,
            ),
          ),
          centerTitle: true,
          actions: const [SizedBox(width: 56)],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            Obx(
              () => SettingsSectionCard(
                title: 'الحساب الشخصي',
                children: [
                  SettingsTile(
                    icon: Icons.person_outline_rounded,
                    title: ' اسمك',
                    subtitle: viewModel.userName.value,
                    trailing: const Icon(
                      Icons.edit_outlined,
                      size: 18,
                      color: AppColors.ink,
                    ),
                    onTap: () => viewModel.showEditNameSheet(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => SettingsSectionCard(
                title: 'التفضيلات',
                children: [
                  SettingsTile(
                    icon: Icons.notifications_none_rounded,
                    title: 'التذكيرات اليومية',
                    subtitle: 'تنبيه دوري لمتابعة الأهداف الجارية (8:30 م)',
                    trailing: Switch.adaptive(
                      value: viewModel.isNotificationsEnabled.value,
                      activeTrackColor: AppColors.ink,
                      onChanged: viewModel.toggleNotifications,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SettingsSectionCard(
              title: 'البيانات والتخزين',
              children: [
                SettingsTile(
                  icon: Icons.flag_outlined,
                  title: 'إجمالي الأهداف',
                  trailing: Text(
                    '${viewModel.totalGoalsCount}',
                    style: AppTypography.ledgerNumber.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink,
                    ),
                  ),
                  showDivider: true,
                ),
                SettingsTile(
                  icon: Icons.task_alt_rounded,
                  iconColor: AppColors.completed,
                  title: 'الأهداف المكتملة',
                  trailing: Text(
                    '${viewModel.completedGoalsCount}',
                    style: AppTypography.ledgerNumber.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.completed,
                    ),
                  ),
                  showDivider: true,
                ),
                SettingsTile(
                  icon: Icons.delete_sweep_outlined,
                  iconColor: AppColors.seal,
                  title: 'مسح كافة الأهداف',
                  subtitle: 'حذف جميع الأهداف والخطوات نهائياً',
                  onTap: viewModel.confirmClearAllData,
                ),
              ],
            ),
            const SizedBox(height: 20),
            SettingsSectionCard(
              title: 'حول التطبيق',
              children: [
                SettingsTile(
                  icon: Icons.info_outline_rounded,
                  title: 'عن تطبيق أهدافي',
                  subtitle: viewModel.appDescription,
                  showDivider: true,
                ),
                SettingsTile(
                  icon: Icons.code_rounded,
                  title: 'المطور',
                  subtitle: viewModel.developerName,
                  trailing: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 14,
                    color: AppColors.textMuted,
                  ),
                  onTap: () => Get.to(() => const DeveloperView()),
                  showDivider: true,
                ),
                SettingsTile(
                  icon: Icons.verified_outlined,
                  title: 'الإصدار',
                  trailing: Text(
                    'v${viewModel.appVersion}',
                    style: AppTypography.ledgerNumber.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}