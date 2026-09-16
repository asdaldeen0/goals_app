import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals/shared/custom_badge.dart';
import 'package:goals/shared/custom_text_field.dart';
import 'package:goals/widgets/addview/appbar_view.dart';
import 'package:goals/widgets/addview/category_selector.dart';
import 'package:goals/widgets/addview/date_range_selector.dart';
import 'package:goals/widgets/addview/save_goal_button.dart';
import 'package:goals/widgets/addview/section_card.dart';
import 'package:goals/widgets/addview/sub_goals_list.dart';
import '../core/app_colors.dart';
import '../view_models/add_goal_view_model.dart';

class AddGoalView extends StatelessWidget {
  const AddGoalView({super.key});

  @override
  Widget build(BuildContext context) {
    final AddGoalViewModel vm = Get.put(AddGoalViewModel());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBarAdd(title: vm.appBarTitle, onBack: vm.appBarBackAction),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            SectionCard(
              title: 'الهدف الرئيسي',
              icon: Icons.flag_rounded,
              child: Obx(
                () => CustomTextField(
                  controller: vm.titleController,
                  hintText: 'ما الذي ترغب في تحقيقه؟',
                  errorText: vm.titleError.value,
                  onChanged: vm.clearTitleError,
                ),
              ),
            ),

            SectionCard(
              title: 'مجال الهدف',
              icon: Icons.grid_view_rounded,
              child: Obx(
                () => CategorySelector(
                  categories: vm.categories,
                  selectedCategory: vm.selectedCategory.value,
                  onSelect: vm.setCategory,
                ),
              ),
            ),

            Obx(
              () => SectionCard(
                title: 'الفترة الزمنية',
                icon: Icons.calendar_today_rounded,
                trailing: CustomBadge(
                  count: '${vm.durationInDays}',
                  label: 'يوم',
                ),
                child: DateRangeSelector(
                  startDate: vm.startDate.value,
                  endDate: vm.endDate.value,
                  onTap: () => vm.pickDateRange(context),
                ),
              ),
            ),

            Obx(
              () => SectionCard(
                title: 'الخطوات الفرعية',
                icon: Icons.checklist_rtl_rounded,
                trailing: CustomBadge(
                  count: '${vm.subGoalsControllers.length}',
                  label: 'خطوات',
                ),
                child: SubGoalsList(
                  controllers: vm.subGoalsControllers,
                  errors: vm.subGoalErrors.toList(),
                  onAdd: vm.addSubGoal,
                  onRemove: vm.removeSubGoal,
                  onChanged: vm.clearSubGoalError,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SaveGoalButton(onSave: vm.saveGoal),
    );
  }
}
