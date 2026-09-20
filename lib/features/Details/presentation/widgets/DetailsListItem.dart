import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/eating.dart';
import '../../domain/entities/burning.dart';

class DetailsItem extends StatelessWidget {
  const DetailsItem({
    super.key,
    required this.height,
    required this.detailItems,
  });

  final dynamic detailItems;
  final double height;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    bool isEating = detailItems is Eating;
    Color surfaceColor = isDark ? Theme.of(context).cardTheme.color! : Colors.blueGrey[100]!;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: isDark ? 0 : 2,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: surfaceColor,
        ),
        child: isEating ? _buildMealItem(context) : _buildActivityItem(context),
      ),
    );
  }

  Widget _buildActivityItem(BuildContext context) {
    final item = detailItems as Burning;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color iconColor = isDark ? Colors.orange[100]! : Colors.orange[700]!;
    Color innerColor = isDark ? Colors.black.withValues(alpha: 0.1) : Colors.white;
    
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.fitness_center_rounded, size: 18, color: iconColor),
                const SizedBox(width: 8),
                Text(
                  item.activityName ?? '',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.indigo[900],
                  ),
                ),
              ],
            ),
            Text(
              item.date != null ? '${item.date!.day}/${item.date!.month}' : '',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isDark ? Colors.white38 : Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: innerColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoChip(context, Icons.timer_outlined, '${item.duration?.round()} ${S.of(context).min}'),
              _buildInfoChip(context, Icons.local_fire_department_rounded, '${item.calories?.round()} ${S.of(context).cal}', color: Colors.orangeAccent),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMealItem(BuildContext context) {
    final item = detailItems as Eating;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color iconColor = isDark ? Colors.green[100]! : Colors.green[700]!;
    Color innerColor = isDark ? Colors.black.withValues(alpha: 0.1) : Colors.white;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.restaurant_rounded, size: 18, color: iconColor),
                const SizedBox(width: 8),
                Text(
                  item.mealName ?? '',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.indigo[900],
                  ),
                ),
              ],
            ),
            Text(
              item.date != null ? '${item.date!.day}/${item.date!.month}' : '',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isDark ? Colors.white38 : Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: innerColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoChip(context, Icons.scale_outlined, '${item.quantity?.round()} ${S.of(context).g}'),
              _buildInfoChip(context, Icons.bolt_rounded, '${item.calories?.round()} ${S.of(context).cal}', color: Colors.greenAccent),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Divider(height: 1, thickness: 0.5),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMacro(context, S.of(context).protein, item.protein ?? 0),
            _buildMacro(context, S.of(context).carb, item.carb ?? 0),
            _buildMacro(context, S.of(context).fat, item.fat ?? 0),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoChip(BuildContext context, IconData icon, String label, {Color? color}) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    // So so light colors for dark mode
    Color? finalColor = color;
    if (isDark && color != null) {
       if (color == Colors.orangeAccent) finalColor = Colors.orange[100];
       if (color == Colors.greenAccent) finalColor = Colors.green[100];
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: (finalColor ?? Colors.grey).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: finalColor ?? (isDark ? Colors.grey[400] : Colors.grey[600])),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: finalColor ?? (isDark ? Colors.grey[300] : Colors.grey[800]))),
        ],
      ),
    );
  }

  Widget _buildMacro(BuildContext context, String label, double value) {
    return Column(
      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 10)),
        Text('${value.round()}g', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      ],
    );
  }
}
