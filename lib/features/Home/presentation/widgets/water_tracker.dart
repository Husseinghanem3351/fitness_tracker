import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../../../../global/global.dart';
import '../../../../global/global_methods.dart';
import '../cubit/cubit.dart';

class WaterTracker extends StatelessWidget {
  const WaterTracker({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color surfaceColor = isDark ? Theme.of(context).cardTheme.color! : Colors.blueGrey[100]!;
    Color innerColor = Colors.white;
    Color waterBlue = isDark ? Colors.blue[300]! : Colors.blue[700]!;
    
    double progress = waterRequired > 0 ? (HomeCubit.get(context).liters / waterRequired) : 0;
    if (progress > 1.0) progress = 1.0;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 10),
            blurRadius: 20,
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).waterTracker,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: isDark ? Colors.white : Colors.indigo[900],
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${S.of(context).goal}: $waterRequired ${S.of(context).liter}',
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.indigo[300],
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isDark ? Colors.blue.withValues(alpha: 0.15) : innerColor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: isDark ? Colors.blue.withValues(alpha: 0.1) : Colors.transparent),
                  boxShadow: isDark ? null : [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4)
                  ],
                ),
                child: Text(
                  '${HomeCubit.get(context).liters} L',
                  style: TextStyle(
                    color: waterBlue,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 12,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.blue.withValues(alpha: 0.05),
                valueColor: AlwaysStoppedAnimation<Color>(waterBlue),
              ),
            ),
          ),
          const SizedBox(height: 25),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ...List<Widget>.generate(
                (HomeCubit.get(context).liters / 0.25).floor(),
                (index) => GestureDetector(
                  onTap: () {
                  HomeCubit.get(context).removeGlass();
                  HomeCubit.get(context).updatePetMood(
                    customMessage: isArabic() ? "أوه، تخلصنا من بعض الماء؟ 💧" : "Oh, tipped some water out? 💧",
                  );
                },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.blue.withValues(alpha: 0.15) : innerColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: isDark ? null : [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2))
                      ],
                    ),
                    child: Icon(
                      Icons.local_drink_rounded,
                      color: waterBlue,
                      size: 24,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  HomeCubit.get(context).addGlass();
                  HomeCubit.get(context).updatePetMood(
                    customMessage: isArabic() ? "يا له من انتعاش! 🧊" : "So refreshing! 🧊",
                  );
                },
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: isDark ? Colors.white12 : Colors.indigo.withValues(alpha: 0.1)),
                    boxShadow: isDark ? null : [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2))
                    ],
                  ),
                  child: Icon(
                    Icons.add_rounded,
                    color: isDark ? Colors.blue : Colors.indigo[900],
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
