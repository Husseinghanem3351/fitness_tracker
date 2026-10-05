import '../../domain/entities/meal.dart';

class MealModel extends Meal {
  const MealModel({
    super.id,
    required super.name,
    required super.nameAr,
    required super.calories,
    required super.protein,
    required super.carb,
    required super.fat,
    super.defaultValue,
    super.defaultValueName,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      defaultValue: (json['defaultQuantity'] as num?)?.toDouble() ?? 0.0,
      defaultValueName: json['nameDefaultQuantity'],
      calories: (json['calories'] as num?)?.toDouble() ?? 0.0,
      id: json['id'],
      name: json['name'] ?? '',
      nameAr: json['nameAr'] ?? '',
      fat: (json['fat'] as num?)?.toDouble() ?? 0.0,
      carb: (json['carb'] as num?)?.toDouble() ?? 0.0,
      protein: (json['protein'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'calories': calories,
      'fat': fat,
      'carb': carb,
      'protein': protein,
      'name': name,
      'nameAr': nameAr,
      'nameDefaultQuantity': defaultValueName,
      'defaultQuantity': defaultValue,
    };
  }
}
