import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../../../../global/global_methods.dart';
import '../../../Activities/presentation/pages/ActivitiesScreen.dart';
import '../../../Meals/presentation/pages/mealsScreen.dart';
import '../cubit/cubit.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
    required this.showAddButton,
  });

  final bool showAddButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (showAddButton) ...[
          _buildSpeedDialItem(
            context,
            label: S.of(context).meals,
            icon: Icons.restaurant_rounded,
            color: Colors.blue, // Changed to Blue as requested
            onTap: () {
              HomeCubit.get(context).changeAddButtonState();
              navigateTo(context, const MealsScreen());
            },
          ),
          const SizedBox(height: 16),
          _buildSpeedDialItem(
            context,
            label: S.of(context).activities,
            icon: Icons.fitness_center_rounded,
            color: Colors.orangeAccent,
            onTap: () {
              HomeCubit.get(context).changeAddButtonState();
              navigateTo(context, const ActivitiesScreen());
            },
          ),
          const SizedBox(height: 16),
        ],
        FloatingActionButton(
          elevation: 4,
          backgroundColor: Colors.white,
          onPressed: () {
            HomeCubit.get(context).changeAddButtonState();
          },
          child: AnimatedRotation(
            duration: const Duration(milliseconds: 200),
            turns: showAddButton ? 0.125 : 0, // 45 degrees
            child: Icon(
              Icons.add_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 32,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpeedDialItem(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Text(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 12),
        FloatingActionButton.small(
          heroTag: label,
          backgroundColor: color,
          onPressed: onTap,
          child: Icon(icon, color: Colors.white),
        ),
      ],
    );
  }
}
