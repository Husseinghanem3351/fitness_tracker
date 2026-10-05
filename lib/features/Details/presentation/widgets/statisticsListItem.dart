import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/dailyCalories.dart';

class StatisticsListItem extends StatelessWidget {
  const StatisticsListItem({super.key, required this.dailyCalories});
  final DailyCalories dailyCalories;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color blueGrey = isDark ? const Color(0xFF37474F) : const Color(0xFFb8cede);
    Color innerSurface = isDark ? Colors.black.withValues(alpha: 0.2) : Colors.white;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Theme.of(context).cardTheme.color : blueGrey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDark ? Colors.white.withValues(alpha: 0.05) : blueGrey.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          // Date Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dailyCalories.date != null 
                  ? '${dailyCalories.date!.day}/${dailyCalories.date!.month}/${dailyCalories.date!.year}' 
                  : '',
                style: TextStyle(
                  color: isDark ? Colors.indigoAccent[100] : Colors.indigo,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Icon(Icons.calendar_today_rounded, size: 16, color: isDark ? Colors.indigoAccent[100] : Colors.indigo),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Divider(height: 1, thickness: 0.5),
          ),
          
          // Calories Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem(context, S.of(context).eaten, dailyCalories.eatingCal.round().toString(), isDark ? Colors.blue[300]! : Colors.blue),
              _buildStatItem(context, S.of(context).burned, dailyCalories.burnedCal.round().toString(), isDark ? Colors.orange[200]! : Colors.orange[700]!),
              _buildStatItem(context, S.of(context).goal, dailyCalories.goalCalories.round().toString(), isDark ? Colors.indigoAccent[100]! : Colors.indigo),
            ],
          ),
          const SizedBox(height: 20),
          
          // Macros Row
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: innerSurface,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMacroStat(context, S.of(context).protein, dailyCalories.protein.round(), isDark ? Colors.redAccent[200]! : Colors.redAccent[700]!),
                _buildMacroStat(context, S.of(context).carb, dailyCalories.carb.round(), isDark ? Colors.blueAccent[200]! : Colors.blue[700]!),
                _buildMacroStat(context, S.of(context).fat, dailyCalories.fat.round(), isDark ? Colors.orangeAccent[200]! : Colors.orange[700]!),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildMacroStat(BuildContext context, String label, int value, Color color) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 11),
        ),
        Text(
          '$value ${S.of(context).g}',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87, 
            fontWeight: FontWeight.bold, 
            fontSize: 12
          ),
        ),
      ],
    );
  }
}
