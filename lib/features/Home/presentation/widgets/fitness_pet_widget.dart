import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/l10n.dart';
import '../../../../global/global.dart';
import '../../../../global/global_methods.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class FitnessPetWidget extends StatefulWidget {
  const FitnessPetWidget({super.key});

  @override
  State<FitnessPetWidget> createState() => _FitnessPetWidgetState();
}

class _FitnessPetWidgetState extends State<FitnessPetWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward().then((_) => _controller.reverse());
    // Give a poke message
    HomeCubit.get(context).updatePetMood(
      customMessage: isArabic() ? "هي! هذا يدغدغ! 😂" : "Hey! That tickles! 😂",
    );
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

        // Use the temporary message if available, otherwise use mood message
        String displayMessage = currentPetMessage ?? moodMessage;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // The Pet with interaction
              GestureDetector(
                onTap: _handleTap,
                child: ScaleTransition(
                  scale: _animation,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(petEmoji, style: const TextStyle(fontSize: 50)),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              // Speech Bubble
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    key: ValueKey(displayMessage),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.indigo.withValues(alpha: 0.2) : Colors.white,
                      borderRadius: const BorderRadiusDirectional.only(
                        topStart: Radius.circular(20),
                        topEnd: Radius.circular(20),
                        bottomEnd: Radius.circular(20),
                      ),
                      boxShadow: isDark ? null : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                      border: Border.all(color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.indigo.withValues(alpha: 0.1)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        const SizedBox(height: 4),
                        Text(
                          displayMessage,
                          style: TextStyle(
                            fontSize: 14, 
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
        );
      },
    );
  }
}
