# Recipe-Based Custom Meal Creation

This plan outlines the redesign of the "Custom Meal" feature to work like a recipe builder, calculating macros automatically from selected ingredients.

## Proposed Changes

### Logic Refinement

#### [SaveCustomMeal.dart](file:///C:/Users/Hussein/AndroidStudioProjects/fitness_tracker/lib/features/Meals/presentation/pages/SaveCustomMeal.dart)
- **Automatic Macro Calculation**:
    - Implement a weighted average formula to calculate the final meal's macros per 100g.
    - **Formula**: `Total_Macro = (Item1_Macro * Item1_Grams / 100 + Item2_Macro * Item2_Grams / 100) / (Total_Grams / 100)`.
- **Dynamic UI**:
    - Show the running total of Calories/Protein/Carbs/Fats as the user adjusts quantities for each ingredient.
    - Remove all manual text fields for macros.
- **Improved UX**: Use the standard `blueGrey` card style for ingredient rows and ensure clear "Grams" input.

### Feature Consolidation

#### [customMeals.dart](file:///C:/Users/Hussein/AndroidStudioProjects/fitness_tracker/lib/features/Meals/presentation/pages/customMeals.dart)
- **Ingredient Selection**: Ensure users can pick from both `basicMeals` and previously saved `customMeals`.
- **Navigation**: Pass the selected list to the new `SaveCustomMeal` logic.

#### [add new meal sheet.dart](file:///C:/Users/Hussein/AndroidStudioProjects/fitness_tracker/lib/features/Meals/presentation/widgets/add_new_meal_sheet.dart)
- **Deprecation**: This manual entry sheet will be replaced by the recipe flow to ensure users only use reliable data sources for calculations.

## Verification Plan

### Manual Verification
1. **Recipe Test**:
    - Select **100g Boiled Rice** (130 kcal) and **100g Chicken Breast** (165 kcal).
    - *Expected Total*: 295 kcal for 200g.
    - *Expected Per 100g*: 147.5 kcal.
    - Verify that the app calculates and saves these values correctly.
2. **UI Accuracy**: Verify that as you change "50g" to "150g" for an ingredient, the "Total Calories" preview updates instantly.
3. **Save & Log**: Save the new custom meal (e.g., "Rice and Chicken Bowl"). Find it in the Meals screen, log it, and verify it updates the Dashboard correctly.
