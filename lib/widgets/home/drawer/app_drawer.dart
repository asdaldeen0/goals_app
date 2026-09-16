import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals/core/app_colors.dart';
import 'package:goals/core/app_typography.dart';
import 'package:goals/view/developer_view.dart';
import 'package:goals/view/settings_view.dart';
import 'package:goals/view_models/home_dashboard_viewmodel.dart';
import 'about_app_bottom_sheet.dart';
import 'drawer_header_card.dart';
import 'drawer_menu_item.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeDashboardViewModel vm = Get.find<HomeDashboardViewModel>();

    return Drawer(
      backgroundColor: AppColors.background,
      elevation: 16,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(28)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Obx(
              () => DrawerHeaderCard(
                userName: vm.userName.value,
                subtitle: 'لوحة تتبع الأهداف اليومية',
                completedGoals: vm.completedGoalsCount,
                totalGoals: vm.totalGoalsCount,
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  DrawerMenuItem(
                    icon: Icons.home_rounded,
                    title: 'الرئيسية',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(height: 4),
                  DrawerMenuItem(
                    icon: Icons.settings_outlined,
                    title: 'الإعدادات',
                    onTap: () {
                      Navigator.of(context).pop();
                      Get.to(() => const SettingsView());
                    },
                  ),
                  const SizedBox(height: 4),
                  DrawerMenuItem(
                    icon: Icons.info_outline_rounded,
                    title: 'عن التطبيق',
                    onTap: () {
                      Navigator.of(context).pop();
                      AboutAppBottomSheet.show(context);
                    },
                  ),
                  const SizedBox(height: 4),
                  DrawerMenuItem(
                    icon: Icons.person_pin_circle_outlined,
                    title: 'عن المطور',
                    onTap: () {
                      Navigator.of(context).pop();
                      Get.to(() => const DeveloperView());
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Text(
                'تطبيق أهدافي • الإصدار 1.0.0',
                style: AppTypography.label.copyWith(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textMuted.withValues(alpha: 0.8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
