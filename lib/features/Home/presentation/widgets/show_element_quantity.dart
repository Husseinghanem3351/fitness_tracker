import 'package:flutter/material.dart';

class ElementQuantity extends StatelessWidget {
  const ElementQuantity({
    super.key,
    required this.quantity,
    required this.name,
    required this.goal,
    required this.barColor,
  });

  final double quantity;
  final String name;
  final double goal;
  final Color barColor;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    double progress = goal > 0 ? (quantity / goal) : 0;
    if (progress > 1.0) progress = 1.0;

    // Use specific colors for macro names
    Color textColor = barColor; 
    if (!isDark && barColor == Colors.white) {
        textColor = Colors.blueGrey[800]!; // Fallback for white bar in light mode
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold, // Bold weight as requested
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 75,
          height: 8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05),
              valueColor: AlwaysStoppedAnimation<Color>(barColor),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '${quantity.round()} / ${goal.round()} g',
          style: TextStyle(
            color: isDark ? Colors.white.withOpacity(0.9) : Colors.black87,
            fontSize: 10,
            fontWeight: FontWeight.bold, // Bold weight as requested
          ),
        ),
      ],
    );
  }
}
