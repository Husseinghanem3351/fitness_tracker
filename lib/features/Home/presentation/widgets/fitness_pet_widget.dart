import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zelora/features/Home/data/pet_reaction_engine.dart';
import 'package:zelora/features/Home/presentation/cubit/cubit.dart';
import 'package:zelora/features/Home/presentation/cubit/states.dart';
import '../../../../generated/l10n.dart';
import '../../../../global/global.dart';
import '../../../../global/global_methods.dart';
import '../../../Activities/presentation/pages/ActivitiesScreen.dart';
import '../../../Meals/presentation/pages/mealsScreen.dart';

class FitnessPetWidget extends StatefulWidget {
  const FitnessPetWidget({super.key});

  @override
  State<FitnessPetWidget> createState() => _FitnessPetWidgetState();
}

class _FitnessPetWidgetState extends State<FitnessPetWidget> with TickerProviderStateMixin {
  late AnimationController _tapController;
  late Animation<double> _tapAnimation;
  
  late AnimationController _particleController;
  late Animation<double> _particleOpacity;
  late Animation<Offset> _particleOffset;
  String _floatingXpText = "+10 XP ⭐";

  bool _isHoveredOverPet = false;

  @override
  void initState() {
    super.initState();
    _tapController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _tapAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _tapController, curve: Curves.elasticOut),
    );

    _particleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _particleOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _particleController, curve: const Interval(0.5, 1.0, curve: Curves.easeOut)),
    );
    _particleOffset = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -1.2),
    ).animate(CurvedAnimation(parent: _particleController, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _tapController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  void _triggerXpParticle(String text) {
    setState(() {
      _floatingXpText = text;
    });
    _particleController.reset();
    _particleController.forward();
  }

  void _handleTap() {
    HapticFeedback.lightImpact();
    _tapController.forward().then((_) => _tapController.reverse());
    
    final reaction = PetReactionEngine.getRandomReaction('poke');
    HomeCubit.get(context).updatePetMood(customMessage: reaction);
  }

  void _handleDrop(String itemType) {
    HapticFeedback.heavyImpact();
    
    if (itemType == 'water') {
      HomeCubit.get(context).addGlass();
      _triggerXpParticle("+10 XP ⭐");
      final reaction = PetReactionEngine.getRandomReaction('water');
      HomeCubit.get(context).updatePetMood(customMessage: reaction);
    } else if (itemType == 'meal') {
      final reaction = PetReactionEngine.getRandomReaction('meal');
      HomeCubit.get(context).updatePetMood(customMessage: reaction);
      navigateTo(context, const MealsScreen());
    } else if (itemType == 'workout') {
      final reaction = PetReactionEngine.getRandomReaction('workout');
      HomeCubit.get(context).updatePetMood(customMessage: reaction);
      navigateTo(context, const ActivitiesScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        String petEmoji = "😊";
        String moodMessage = S.of(context).petMsgHappy;

        switch (currentPetMood) {
          case PetMood.happy: petEmoji = "😊"; moodMessage = S.of(context).petMsgHappy; break;
          case PetMood.thirsty: petEmoji = "🌵"; moodMessage = S.of(context).petMsgThirsty; break;
          case PetMood.refreshed: petEmoji = "🌊"; moodMessage = S.of(context).petMsgRefreshed; break;
          case PetMood.hungry: petEmoji = "🍎"; moodMessage = S.of(context).petMsgHungry; break;
          case PetMood.full: petEmoji = "😵"; moodMessage = S.of(context).petMsgFull; break;
          case PetMood.proud: petEmoji = "💪"; moodMessage = S.of(context).petMsgProud; break;
          case PetMood.lazy: petEmoji = "🥺"; moodMessage = S.of(context).petMsgLazy; break;
        }

        if (_isHoveredOverPet) {
          petEmoji = "😮"; // Excited mouth open when item dragged over!
        }

        String displayMessage = currentPetMessage ?? moodMessage;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Zelo Pet DragTarget & Avatar
                  Stack(
                    alignment: Alignment.topCenter,
                    clipBehavior: Clip.none,
                    children: [
                      // Floating Particle FX
                      AnimatedBuilder(
                        animation: _particleController,
                        builder: (context, child) => SlideTransition(
                          position: _particleOffset,
                          child: FadeTransition(
                            opacity: _particleOpacity,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(color: Colors.black26, blurRadius: 6)
                                ],
                              ),
                              child: Text(
                                _floatingXpText,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Drag Target for Zelo
                      DragTarget<String>(
                        onWillAcceptWithDetails: (details) {
                          HapticFeedback.selectionClick();
                          setState(() => _isHoveredOverPet = true);
                          return true;
                        },
                        onLeave: (data) {
                          setState(() => _isHoveredOverPet = false);
                        },
                        onAcceptWithDetails: (details) {
                          setState(() => _isHoveredOverPet = false);
                          _handleDrop(details.data);
                        },
                        builder: (context, candidateData, rejectedData) {
                          return GestureDetector(
                            onTap: _handleTap,
                            child: ScaleTransition(
                              scale: _tapAnimation,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _isHoveredOverPet
                                      ? (isDark
                                          ? Colors.indigoAccent.withValues(alpha: 0.3)
                                          : Colors.amber.withValues(alpha: 0.3))
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: _isHoveredOverPet
                                        ? Colors.amber
                                        : Colors.transparent,
                                    width: 3,
                                  ),
                                ),
                                child: Text(petEmoji, style: const TextStyle(fontSize: 52)),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  // Speech Bubble
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        key: ValueKey(displayMessage),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.indigo.withValues(alpha: 0.2) : Colors.white,
                          borderRadius: const BorderRadiusDirectional.only(
                            topStart: Radius.circular(20),
                            topEnd: Radius.circular(20),
                            bottomEnd: Radius.circular(20),
                          ),
                          boxShadow: isDark
                              ? null
                              : [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  )
                                ],
                          border: Border.all(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.1)
                                  : Colors.indigo.withValues(alpha: 0.1)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.of(context).petZelo,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                    color: isDark ? Colors.indigoAccent[100] : Colors.indigo,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    "🔥 $currentStreak ${isArabic() ? "أيام" : "Days"} • ⭐ Lvl $petLevel",
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              displayMessage,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Glassmorphic Quick Feed Dock / Tray
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: isDark ? Colors.white12 : Colors.indigo.withValues(alpha: 0.1)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildDraggableItem(
                      data: 'water',
                      emoji: '💧',
                      label: isArabic() ? "ماء" : "Water",
                      isDark: isDark,
                    ),
                    _buildDraggableItem(
                      data: 'meal',
                      emoji: '🥗',
                      label: isArabic() ? "وجبة" : "Meal",
                      isDark: isDark,
                    ),
                    _buildDraggableItem(
                      data: 'workout',
                      emoji: '🏋️',
                      label: isArabic() ? "تمرين" : "Workout",
                      isDark: isDark,
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

  Widget _buildDraggableItem({
    required String data,
    required String emoji,
    required String label,
    required bool isDark,
  }) {
    return Draggable<String>(
      data: data,
      feedback: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E2430) : Colors.white,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 16,
                offset: Offset(0, 6),
              )
            ],
          ),
          child: Text(emoji, style: const TextStyle(fontSize: 38)),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: _buildItemCard(emoji: emoji, label: label, isDark: isDark),
      ),
      child: _buildItemCard(emoji: emoji, label: label, isDark: isDark),
    );
  }

  Widget _buildItemCard({
    required String emoji,
    required String label,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? Colors.indigo.withValues(alpha: 0.15) : Colors.indigo.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.indigoAccent[100] : Colors.indigo[900],
            ),
          ),
        ],
      ),
    );
  }
}
