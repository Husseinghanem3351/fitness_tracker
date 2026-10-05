import 'dart:math';
import '../../../../global/global_methods.dart';

class PetReactionEngine {
  static final Random _random = Random();
  static int _lastWaterIndex = -1;
  static int _lastMealIndex = -1;
  static int _lastWorkoutIndex = -1;
  static int _lastPokeIndex = -1;

  static final List<Map<String, String>> _waterReactions = [
    {
      "en": "Gulp gulp... AHHH! Hydro-power 100%! ⚡🌊 (+10 XP)",
      "ar": "بق بق بق... آاه! طاقة الهيدرو 100%! ⚡🌊 (+10 XP)"
    },
    {
      "en": "Splish splash! My cells are dancing! 🕺💧 (+10 XP)",
      "ar": "سبلاش! خلايا جسمي بترقص! 🕺💧 (+10 XP)"
    },
    {
      "en": "Ice cold water! Brain freeze!! 🥶🧊 (+10 XP)",
      "ar": "ماء مثلج! تجمد عقلي!! 🥶🧊 (+10 XP)"
    },
    {
      "en": "So crisp! Hydration is my middle name! 😎💧 (+10 XP)",
      "ar": "منعش جداً! الارتواء هو عنواني! 😎💧 (+10 XP)"
    },
    {
      "en": "Glug glug... Clear skin & high energy loading! ✨🌊 (+10 XP)",
      "ar": "جرعة نشاط وطاقة متجددة! ✨🌊 (+10 XP)"
    },
  ];

  static final List<Map<String, String>> _mealReactions = [
    {
      "en": "NOM NOM NOM! Delicious fuel! 😋🍕 (+20 XP)",
      "ar": "نم نم نم! وقود لذيذ جداً! 😋🍕 (+20 XP)"
    },
    {
      "en": "Burp! 😳 Excuse me! That went straight to muscle building!",
      "ar": "عذراً! 😳 هذا الطعام ذهب مباشرةً لبناء العضلات!"
    },
    {
      "en": "Cheesy goodness activated! 🧀 Don't tell our trainer! 🤫",
      "ar": "طعام لذيذ جداً! 🧀 لا تخبر المدرب! 🤫"
    },
    {
      "en": "My tummy is singing happy songs right now! 🎵🍲",
      "ar": "بطني يغني أغاني السعادة الآن! 🎵🍲"
    },
    {
      "en": "Master Chef status! That hit the spot! 👌🔥",
      "ar": "وجبة احترافية! جاءت في وقتها تماماً! 👌🔥"
    },
  ];

  static final List<Map<String, String>> _workoutReactions = [
    {
      "en": "RARRR! Muscle mode ON! Look at these gains! 💪🦁 (+30 XP)",
      "ar": "رائع! وضع الوحش يعمل! انظر لهذه العضلات! 💪🦁 (+30 XP)"
    },
    {
      "en": "Phew! 20 reps done! Where is my sweat towel?! 💦 (+30 XP)",
      "ar": "فوف! جولة تمرين ممتازة! أين منشفتي؟! 💦 (+30 XP)"
    },
    {
      "en": "Feel the burn! 🔥 We are unstoppable today! (+30 XP)",
      "ar": "اشعر بالحماس! 🔥 لا أحد يستطيع إيقافنا اليوم! (+30 XP)"
    },
    {
      "en": "Sweat is just fat crying! Keep pushing!! 💦🏃 (+30 XP)",
      "ar": "العرق هو الدهون وهي تبكي! استمر في التقدم!! 💦🏃 (+30 XP)"
    },
  ];

  static final List<Map<String, String>> _pokeReactions = [
    {
      "en": "Hey! That tickles! 😂",
      "ar": "هي! هذا يدغدغ! 😂"
    },
    {
      "en": "Bloop! Zelo is awake and watching you! 👀✨",
      "ar": "بلووب! زيلو مستيقظ ويراقب إنجازك! 👀✨"
    },
    {
      "en": "Touch detected! Ready for a workout? 🏋️‍♂️",
      "ar": "تم استشعار اللمس! هل أنت جاهز للتمرين؟ 🏋️‍♂️"
    },
    {
      "en": "Poke me one more time and I will eat your snacks! 🍪😈",
      "ar": "ادغدغني مرة أخرى وسآكل وجبتك الخفيفة! 🍪😈"
    },
  ];

  static String getRandomReaction(String category) {
    List<Map<String, String>> pool;
    int lastIdx;

    switch (category) {
      case 'water':
        pool = _waterReactions;
        lastIdx = _lastWaterIndex;
        break;
      case 'meal':
        pool = _mealReactions;
        lastIdx = _lastMealIndex;
        break;
      case 'workout':
        pool = _workoutReactions;
        lastIdx = _lastWorkoutIndex;
        break;
      default:
        pool = _pokeReactions;
        lastIdx = _lastPokeIndex;
        break;
    }

    int nextIdx = _random.nextInt(pool.length);
    if (nextIdx == lastIdx && pool.length > 1) {
      nextIdx = (nextIdx + 1) % pool.length;
    }

    switch (category) {
      case 'water': _lastWaterIndex = nextIdx; break;
      case 'meal': _lastMealIndex = nextIdx; break;
      case 'workout': _lastWorkoutIndex = nextIdx; break;
      default: _lastPokeIndex = nextIdx; break;
    }

    final reactionMap = pool[nextIdx];
    return isArabic() ? reactionMap["ar"]! : reactionMap["en"]!;
  }
}
