import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../../../../global/global_methods.dart';
import '../../../../global/widgets/default_button.dart';
import '../../../../global/widgets/delete_dialog.dart';
import '../../domain/entities/meal.dart';
import '../bloc/MealsCubit/MealsCubit.dart';

class MealElement extends StatelessWidget {
  const MealElement({
    super.key,
    required this.meal,
    required this.isAllowDelete,
  });

  final Meal meal;
  final bool isAllowDelete;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      elevation: isDark ? 0 : 4,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).cardTheme.color,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    isArabic() ? meal.nameAr : meal.name,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.indigoAccent[100] : Colors.black,
                        ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: (isDark ? Colors.indigoAccent[100]! : Theme.of(context).colorScheme.primary).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${meal.calories.round()}',
                        style: TextStyle(
                          color: isDark ? Colors.indigoAccent[100] : Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        S.of(context).cal,
                        style: TextStyle(
                          color: isDark ? Colors.indigoAccent[100] : Theme.of(context).colorScheme.primary,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(height: 1, thickness: 0.5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMacro(context, S.of(context).protein, meal.protein),
                _buildMacro(context, S.of(context).carb, meal.carb),
                _buildMacro(context, S.of(context).fat, meal.fat),
              ],
            ),
            if (isAllowDelete) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    deleteDialog(
                      context: context,
                      message: S.of(context).deleteConfirm,
                      onPressed: () {
                        MealsCubit.get(context).deleteMeal(meal.id!);
                        Navigator.pop(context);
                      },
                    );
                  },
                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMacro(BuildContext context, String label, double value) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: isDark ? Colors.blueGrey[200] : Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Text(
          '${value.round()}${S.of(context).g}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isDark ? Colors.white : Colors.black87),
        ),
      ],
    );
  }
}
