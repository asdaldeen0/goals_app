import 'package:flutter/material.dart';
import 'package:goals/shared/custom_text_field.dart';
import '../../core/app_colors.dart';
import '../../core/app_typography.dart';

class SubGoalsList extends StatelessWidget {
  final List<TextEditingController> controllers;
  final List<String?> errors;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;
  final void Function(int index, String value) onChanged;

  const SubGoalsList({
    super.key,
    required this.controllers,
    required this.errors,
    required this.onAdd,
    required this.onRemove,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...List.generate(controllers.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    width: 28,
                    height: 28,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.inkWash,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${index + 1}',
                      style: AppTypography.ledgerNumber.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.ink,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomTextField(
                    controller: controllers[index],
                    hintText: 'اكتب الخطوة هنا...',
                    errorText: index < errors.length ? errors[index] : null,
                    onChanged: (val) => onChanged(index, val),
                  ),
                ),
                if (controllers.length > 2) ...[
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
                      onTap: () => onRemove(index),
                      borderRadius: BorderRadius.circular(8),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.remove_circle_outline_rounded,
                          color: AppColors.seal,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        }),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: onAdd,
            icon: const Icon(
              Icons.add_rounded,
              size: 18,
              color: AppColors.ink,
            ),
            label: Text(
              'إضافة خطوة جديدة',
              style: AppTypography.headline.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.ink,
              ),
            ),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
          ),
        ),
      ],
    );
  }
}
