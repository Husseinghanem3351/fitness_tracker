import '../../domain/entities/eating.dart';

class EatingCaloriesModel extends Eating {
  const EatingCaloriesModel({
    super.date,
    super.id,
    super.quantity,
    super.carb,
    super.fat,
    super.mealName,
    super.protein,
    super.calories,
  });

  factory EatingCaloriesModel.fromJson(Map<String, dynamic> json) {
    return EatingCaloriesModel(
      quantity: json['quantity']?.toDouble() ?? 0.0,
      id: json['id'],
      date: json['date'] != null ? DateTime.tryParse(json['date'].toString()) : null,
      carb: json['carb']?.toDouble() ?? 0.0,
      fat: json['fat']?.toDouble() ?? 0.0,
      protein: json['protein']?.toDouble() ?? 0.0,
      mealName: json['name'],
      calories: json['calories']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'quantity': quantity,
      'date': date?.toIso8601String(),
      'carb': carb,
      'fat': fat,
      'protein': protein,
      'name': mealName,
      'calories': calories,
    };
  }
}
