import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../../../../global/global.dart';
import '../../../../global/global_methods.dart';
import '../../domain/entities/activity.dart';

class ActivityElement extends StatelessWidget {
  const ActivityElement({
    super.key,
    required this.activity,
  });

  final Activity activity;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    isArabic() ? activity.titleAr : activity.title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.indigoAccent[100] : Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
                Icon(
                  Icons.fitness_center_rounded,
                  size: 20,
                  color: isDark ? Colors.indigoAccent[100]!.withValues(alpha: 0.7) : Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.directions_run_rounded, size: 16, color: isDark ? Colors.blueGrey[200] : Colors.grey[500]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    isArabic() ? activity.nameAr : activity.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 15,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.local_fire_department_rounded, size: 16, color: isDark ? Colors.orange[100]!.withValues(alpha: 0.7) : Colors.orangeAccent),
                const SizedBox(width: 8),
                Text(
                  S.of(context).calories,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: isDark ? Colors.blueGrey[200] : Colors.blueGrey,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${(personalInfo!.weight * activity.MES).round()}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.orange[100] : Colors.orange[800],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        S.of(context).cal,
                        style: TextStyle(
                          color: isDark ? Colors.orange[100] : Colors.orange[800],
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
