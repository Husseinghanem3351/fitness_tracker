import 'package:fitness_tracker/features/Home/presentation/widgets/show_element_quantity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/l10n.dart';
import '../../../../global/global.dart';
import '../../../Details/presentation/bloc/cubit.dart';
import '../../../Details/presentation/bloc/states.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color surfaceColor = isDark ? Theme.of(context).cardTheme.color! : Colors.blueGrey[100]!;
    Color innerColor = Colors.white;
    Color accentIndigo = isDark ? Colors.indigoAccent[100]! : Colors.indigo[700]!;
    
    return BlocBuilder<DetailsCubit, DetailsStates>(
      builder: (context, state) {
        // Calculations are updated in the background, but we display them here
        double totalBudget = dailyGoalCalories + burningCalories;
        double progress = totalBudget > 0 ? (eatingCalories / totalBudget) : 0;
        if (progress > 1.0) progress = 1.0;

        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 15),
                blurRadius: 30,
                color: Colors.black.withValues(alpha: 0.06),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header Row
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withValues(alpha: 0.05) : innerColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: isDark ? null : [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2))
                  ],
                  border: Border.all(color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.transparent),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSummaryItem(context, S.of(context).goal, dailyGoalCalories.round().toString()),
                    Text("-", style: TextStyle(fontSize: 18, color: isDark ? Colors.white : Colors.indigo[900], fontWeight: FontWeight.bold)),
                    _buildSummaryItem(context, S.of(context).meals, eatingCalories.round().toString()),
                    Text("+", style: TextStyle(fontSize: 18, color: isDark ? Colors.white : Colors.indigo[900], fontWeight: FontWeight.bold)),
                    _buildSummaryItem(context, S.of(context).activities, burningCalories.round().toString()),
                  ],
                ),
              ),
              const SizedBox(height: 35),
              
              // Central Circular Progress
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: height * 0.45,
                      height: height * 0.45,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 16,
                        strokeCap: StrokeCap.round,
                        backgroundColor: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.indigo.withValues(alpha: 0.05),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          eatRemainingCalories < 0 
                            ? Colors.redAccent 
                            : (isDark ? Colors.white : accentIndigo),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${eatRemainingCalories.round()}',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: isDark ? Colors.white : accentIndigo,
                          ),
                        ),
                        Text(
                          S.of(context).remaining,
                          style: TextStyle(
                            color: isDark ? Colors.white70 : Colors.indigo[300],
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 35),

              // Macros Section
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                decoration: BoxDecoration(
                  color: isDark ? Colors.black.withValues(alpha: 0.2) : innerColor,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: isDark ? Colors.transparent : Colors.black.withValues(alpha: 0.02)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElementQuantity(
                      quantity: eatingFat,
                      name: S.of(context).fat,
                      goal: requiredFat,
                      barColor: Colors.orangeAccent[700]!,
                    ),
                    ElementQuantity(
                      quantity: eatingProtein,
                      name: S.of(context).protein,
                      goal: requiredProtein,
                      barColor: Colors.redAccent[700]!,
                    ),
                    ElementQuantity(
                      quantity: eatingCarb,
                      name: S.of(context).carb,
                      goal: requiredCarb,
                      barColor: Colors.lightBlueAccent[700]!,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryItem(BuildContext context, String label, String value) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.indigo[900], 
            fontWeight: FontWeight.bold, 
            fontSize: 18
          ),
        ),
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: isDark ? Colors.white.withValues(alpha: 0.7) : Colors.blueGrey[600],
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
