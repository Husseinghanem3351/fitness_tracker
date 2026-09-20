import '../../domain/entities/dailyCalories.dart';

class DailyCaloriesModel extends DailyCalories {
  const DailyCaloriesModel({
    super.id,
    required super.eatingCal,
    required super.burnedCal,
    required super.goalCalories,
    required super.protein,
    required super.fat,
    required super.carb,
    super.date,
  });

  factory DailyCaloriesModel.fromJson(Map<String, dynamic> json) {
    return DailyCaloriesModel(
      id: json['id'],
      eatingCal: (json['eatingCal'] as num?)?.toDouble() ?? 0.0,
      burnedCal: (json['burnedCal'] as num?)?.toDouble() ?? 0.0,
      goalCalories: (json['goalCalories'] as num?)?.toDouble() ?? 0.0,
      protein: (json['protein'] as num?)?.toDouble() ?? 0.0,
      fat: (json['fat'] as num?)?.toDouble() ?? 0.0,
      carb: (json['carb'] as num?)?.toDouble() ?? 0.0,
      date: json['date'] != null ? DateTime.tryParse(json['date'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'eatingCal': eatingCal,
      'burnedCal': burnedCal,
      'goalCalories': goalCalories,
      'protein': protein,
      'fat': fat,
      'carb': carb,
      'date': date?.toIso8601String().substring(0, 10),
    };
  }

  // Helper method for update operations
  Map<String, dynamic> toUpdateJson() {
    return {
      'eatingCal': eatingCal,
      'burnedCal': burnedCal,
      'goalCalories': goalCalories,
      'protein': protein,
      'fat': fat,
      'carb': carb,
      'date': date?.toIso8601String().substring(0, 10),
    };
  }
}
