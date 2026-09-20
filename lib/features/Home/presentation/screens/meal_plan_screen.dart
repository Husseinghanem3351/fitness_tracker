import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../../../../global/global_methods.dart';
import '../../../../global/data/initial_data.dart';
import '../../../../global/global.dart';
import '../../../Meals/data/models/meal.dart';
import '../../data/cache helper.dart';
import '../../../Details/presentation/bloc/cubit.dart';
import '../../../Details/domain/entities/eating.dart';


class MealPlanScreen extends StatefulWidget {
  const MealPlanScreen({super.key});

  @override
  State<MealPlanScreen> createState() => _MealPlanScreenState();
}

class MealSuggestion {
  final List<(MealModel, double)> items; // Meal and its portion in grams
  final String mealType;
  final String? optionName; // Option 1, Option 2, etc.

  MealSuggestion({required this.items, required this.mealType, this.optionName});

  double get totalCalories => items.fold(0, (sum, pair) => sum + (pair.$1.calories * pair.$2 / 100));
}

class _MealPlanScreenState extends State<MealPlanScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  
  // Track expansion state for each category
  final Map<String, bool> _isExpanded = {
    'Breakfast': false,
    'Lunch': false,
    'Dinner': false,
    'Snack': false,
  };

  Map<String, List<MealSuggestion>> suggestedMeals = {
    'Breakfast': [],
    'Lunch': [],
    'Dinner': [],
    'Snack': [],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _generateSuggestions();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _generateSuggestions() {
    String diet = personalInfo?.dietType ?? 'Standard';

    // 1. Filter database based on diet
    List<MealModel> availableMeals = basicMeals.where((meal) {
      if (diet == 'Vegan') {
        return !['Chicken', 'Beef', 'Salmon', 'Tuna', 'Turkey', 'Shrimp', 'Milk', 'Cheese', 'Egg', 'Honey', 'Labneh', 'Yogurt', 'Cod', 'Butter'].any((keyword) => meal.name.contains(keyword));
      } else if (diet == 'Vegetarian') {
        return !['Chicken', 'Beef', 'Salmon', 'Tuna', 'Turkey', 'Shrimp', 'Cod'].any((keyword) => meal.name.contains(keyword));
      }
      return true;
    }).toList();

    // 2. Specialized lists for combinations
    List<MealModel> proteins = availableMeals.where((m) => m.protein > 15 || (diet != 'Standard' && m.protein > 8)).toList();
    List<MealModel> carbs = availableMeals.where((m) => m.carb > 15 && m.protein < 15).toList();
    List<MealModel> veggies = availableMeals.where((m) => m.calories < 50 && (m.name.contains('Broccoli') || m.name.contains('Spinach') || m.name.contains('Cucumber') || m.name.contains('Salad') || m.name.contains('Olive'))).toList();
    
    List<MealModel> bBase = availableMeals.where((m) => m.name.contains('Oats') || m.name.contains('Egg') || m.name.contains('Bread') || m.name.contains('Pancakes') || m.name.contains('Arabic Bread') || m.name.contains('Manakish') || (diet == 'Vegan' && m.name.contains('Beans'))).toList();
    List<MealModel> bSides = availableMeals.where((m) => m.name.contains('Labneh') || m.name.contains('Honey') || m.name.contains('Jam') || m.name.contains('Feta') || m.name.contains('Ful') || m.name.contains('Hummus') || m.name.contains('Peanut') || m.name.contains('Zaatar') || m.name.contains('Halloumi')).toList();
    List<MealModel> easyDinner = availableMeals.where((m) => m.name.contains('Tuna') || m.name.contains('Sardine') || m.name.contains('Labneh') || m.name.contains('Egg') || m.name.contains('Cheese') || m.name.contains('Hummus') || m.name.contains('Falafel')).toList();
    
    List<MealModel> fruits = availableMeals.where((m) => m.calories > 30 && m.calories < 100 && (m.name.contains('Banana') || m.name.contains('Apple') || m.name.contains('Orange') || m.name.contains('Strawberries') || m.name.contains('Dates'))).toList();
    List<MealModel> nuts = availableMeals.where((m) => m.name.contains('Almonds') || m.name.contains('Chocolate') || m.name.contains('Walnuts') || m.name.contains('Peanut')).toList();
    
    // 3. Generate 10 Options for Breakfast, Lunch, Dinner
    for (int i = 0; i < 10; i++) {
      // BREAKFAST: Authentic Arab Combos
      suggestedMeals['Breakfast']!.add(MealSuggestion(
        optionName: "Option ${i + 1}",
        mealType: 'Breakfast',
        items: [
          (bBase[i % bBase.length], bBase[i % bBase.length].defaultValue ?? 100),
          (bSides[i % bSides.length], bSides[i % bSides.length].defaultValue ?? 30),
          (veggies[i % veggies.length], veggies[i % veggies.length].defaultValue ?? 100),
          (fruits[i % fruits.length], fruits[i % fruits.length].defaultValue ?? 100),
        ],
      ));

      // LUNCH: Main Courses
      suggestedMeals['Lunch']!.add(MealSuggestion(
        optionName: "Option ${i + 1}",
        mealType: 'Lunch',
        items: [
          (proteins[i % proteins.length], proteins[i % proteins.length].defaultValue ?? 150),
          (carbs[i % carbs.length], carbs[i % carbs.length].defaultValue ?? 150),
          (veggies[(i + 2) % veggies.length], veggies[(i + 2) % veggies.length].defaultValue ?? 100),
          (fruits[(i + 1) % fruits.length], fruits[(i + 1) % fruits.length].defaultValue ?? 100),
        ],
      ));

      // DINNER: Easy & Quick
      suggestedMeals['Dinner']!.add(MealSuggestion(
        optionName: "Option ${i + 1}",
        mealType: 'Dinner',
        items: [
          (easyDinner[i % easyDinner.length], easyDinner[i % easyDinner.length].defaultValue ?? 100),
          (bBase[(i + 3) % bBase.length], (bBase[(i + 3) % bBase.length].defaultValue ?? 60)),
          (veggies[(i + 4) % veggies.length], veggies[(i + 4) % veggies.length].defaultValue ?? 100),
          (bSides[(i + 4) % bSides.length], bSides[(i + 4) % bSides.length].defaultValue ?? 30),
        ],
      ));
    }

    // 4. Generate 10 SNACK Options: Each option is ONE single item
    // Combine snack-friendly items into a pool
    List<MealModel> snackPool = [
      ...fruits,
      ...nuts,
      ...availableMeals.where((m) => m.name.contains('Dates') || m.name.contains('Popcorn') || m.name.contains('Rice Cakes') || m.name.contains('Chocolate'))
    ];
    // Remove duplicates if any
    snackPool = snackPool.toSet().toList();

    for (int i = 0; i < 10 && i < snackPool.length; i++) {
      suggestedMeals['Snack']!.add(MealSuggestion(
        optionName: "Option ${i + 1}",
        mealType: 'Snack',
        items: [
          (snackPool[i], snackPool[i].defaultValue ?? 50),
        ],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    String goal = CacheHelper.getData(key: 'goal') ?? 'maintain weight';
    Color appBarColor = isDark ? const Color(0xFF121416) : Colors.white;

    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        title: Text(S.of(context).nutritionGuide, style: TextStyle(color: Colors.indigo[900], fontWeight: FontWeight.bold)),
        backgroundColor: appBarColor,
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.indigo[900]),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.indigo,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.indigo,
          indicatorWeight: 3,
          tabs: [
            Tab(text: S.of(context).suggestedMeals),
            Tab(text: S.of(context).discoverMeals),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSuggestedMealsTab(goal, isDark),
          _buildDiscoverTab(isDark),
        ],
      ),
    );
  }

  Widget _buildSuggestedMealsTab(String goal, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGoalBanner(goal),
          const SizedBox(height: 12),
          _buildDisclaimerBanner(),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                _buildCategorySection(S.of(context).breakfastOptions, suggestedMeals['Breakfast']!, Icons.wb_sunny_rounded, Colors.orange, 'Breakfast'),
                _buildCategorySection(S.of(context).lunchOptions, suggestedMeals['Lunch']!, Icons.fastfood_rounded, Colors.blue, 'Lunch'),
                _buildCategorySection(S.of(context).dinnerOptions, suggestedMeals['Dinner']!, Icons.nightlight_round, Colors.indigo, 'Dinner'),
                _buildCategorySection(S.of(context).snackOptions, suggestedMeals['Snack']!, Icons.cookie_rounded, Colors.brown, 'Snack'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(String title, List<MealSuggestion> options, IconData icon, Color color, String categoryKey) {
    bool expanded = _isExpanded[categoryKey] ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => setState(() => _isExpanded[categoryKey] = !expanded),
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            child: Row(
              children: [
                Icon(icon, color: color, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title, 
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.indigo.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        expanded ? S.of(context).hideOptions : S.of(context).showOptions,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.indigo),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        expanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                        color: Colors.indigo,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (expanded)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: options.length,
            itemBuilder: (context, index) {
              final suggestion = options[index];
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 16),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(suggestion.optionName ?? "", style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.indigo)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: Colors.indigo.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                              child: Text("${suggestion.totalCalories.round()} kcal", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.indigo)),
                            ),
                          ],
                        ),
                        const Divider(height: 20),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: suggestion.items.map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: Row(
                              children: [
                                const Icon(Icons.check_circle_outline, size: 14, color: Colors.blueGrey),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    isArabic() 
                                      ? "${item.$1.nameAr} (${item.$1.defaultValueName} / ${item.$2.round()}غ)" 
                                      : "${item.$1.name} (${item.$1.defaultValueName} / ${item.$2.round()}g)",
                                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          )).toList(),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _showAcceptDialog(suggestion),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(S.of(context).accept, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        const Divider(height: 1),
      ],
    );
  }

  void _showAcceptDialog(MealSuggestion suggestion) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).acceptMeal(suggestion.mealType)),
        content: Text(S.of(context).acceptMealBody(suggestion.totalCalories.round().toString())),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(S.of(context).cancel)),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await _acceptMeal(suggestion);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
            child: Text(S.of(context).confirm, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<void> _acceptMeal(MealSuggestion suggestion) async {
    final detailsCubit = DetailsCubit.get(context);
    
    for (var item in suggestion.items) {
      final meal = item.$1;
      final grams = item.$2;
      final calories = meal.calories * grams / 100;
      final protein = meal.protein * grams / 100;
      final carb = meal.carb * grams / 100;
      final fat = meal.fat * grams / 100;

      await detailsCubit.addToEatingCalories(
        Eating(
          mealName: isArabic() ? meal.nameAr : meal.name,
          quantity: grams,
          calories: calories,
          protein: protein,
          carb: carb,
          fat: fat,
          date: DateTime.now(),
        ),
        context,
      );
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).mealTypeLogged(suggestion.mealType)),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Widget _buildDiscoverTab(bool isDark) {
    String diet = personalInfo?.dietType ?? 'Standard';
    List<MealModel> filteredMeals = basicMeals.where((meal) {
      final name = isArabic() ? meal.nameAr.toLowerCase() : meal.name.toLowerCase();
      bool matchesSearch = name.contains(_searchQuery.toLowerCase());
      
      bool matchesDiet = true;
      if (diet == 'Vegan') {
        matchesDiet = !['Chicken', 'Beef', 'Salmon', 'Tuna', 'Turkey', 'Shrimp', 'Milk', 'Cheese', 'Egg', 'Honey', 'Labneh', 'Yogurt', 'Cod', 'Butter'].any((keyword) => meal.name.contains(keyword));
      } else if (diet == 'Vegetarian') {
        matchesDiet = !['Chicken', 'Beef', 'Salmon', 'Tuna', 'Turkey', 'Shrimp', 'Cod'].any((keyword) => meal.name.contains(keyword));
      }
      
      return matchesSearch && matchesDiet;
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: TextField(
            controller: _searchController,
            onChanged: (value) => setState(() => _searchQuery = value),
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
            decoration: InputDecoration(
              hintText: S.of(context).searchMeals,
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: const Icon(Icons.search, color: Colors.indigo),
              filled: true,
              fillColor: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            physics: const BouncingScrollPhysics(),
            itemCount: filteredMeals.length,
            itemBuilder: (context, index) {
              final meal = filteredMeals[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 0,
                color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.grey[50],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.indigo.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.restaurant_rounded, color: Colors.indigo),
                  ),
                  title: Text(isArabic() ? meal.nameAr : meal.name, 
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  subtitle: Row(
                    children: [
                      _buildMacroSmall("P", meal.protein, Colors.redAccent),
                      const SizedBox(width: 8),
                      _buildMacroSmall("C", meal.carb, Colors.blue),
                      const SizedBox(width: 8),
                      _buildMacroSmall("F", meal.fat, Colors.orange),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("${meal.calories.round()}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo, fontSize: 16)),
                          Text("${S.of(context).cal}/${S.of(context).per100g}", style: const TextStyle(fontSize: 9, color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(width: 12),
                      IconButton(
                        onPressed: () => _showDiscoveryLogDialog(meal),
                        icon: const Icon(Icons.add_circle_outline_rounded, color: Colors.indigo),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showDiscoveryLogDialog(MealModel meal, {double initialWeight = 100}) {
    final TextEditingController gramController = TextEditingController(text: initialWeight.round().toString());
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).logMeal(isArabic() ? meal.nameAr : meal.name)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(S.of(context).enterQuantity),
            const SizedBox(height: 15),
            TextField(
              controller: gramController,
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration: InputDecoration(
                labelText: S.of(context).weightG,
                suffixText: S.of(context).g,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(S.of(context).cancel)),
          ElevatedButton(
            onPressed: () {
              final double grams = double.tryParse(gramController.text) ?? 100;
              _logIndividualMeal(meal, grams);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
            child: Text(S.of(context).addToTracker, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _logIndividualMeal(MealModel meal, double grams) {
    final detailsCubit = DetailsCubit.get(context);
    final calories = meal.calories * grams / 100;
    final protein = meal.protein * grams / 100;
    final carb = meal.carb * grams / 100;
    final fat = meal.fat * grams / 100;

    detailsCubit.addToEatingCalories(
      Eating(
        mealName: isArabic() ? meal.nameAr : meal.name,
        quantity: grams,
        calories: calories,
        protein: protein,
        carb: carb,
        fat: fat,
        date: DateTime.now(),
      ),
      context,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.of(context).mealLogged(isArabic() ? meal.nameAr : meal.name, grams.toString())),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildMacroSmall(String label, double val, Color color) {
    return Text("$label: ${val.round()}g", style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold));
  }

  Widget _buildGoalBanner(String goal) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.indigo.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.indigo.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome_rounded, color: Colors.indigo),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).highPerformanceMenu, style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.w900, fontSize: 10, letterSpacing: 1)),
                const SizedBox(height: 2),
                Text(
                  "${S.of(context).optimizedForGoal}: $goal",
                  style: TextStyle(color: Colors.indigo[900], fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisclaimerBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, color: Colors.orange, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              S.of(context).disclaimerText,
              style: const TextStyle(color: Colors.orange, fontSize: 10, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}
