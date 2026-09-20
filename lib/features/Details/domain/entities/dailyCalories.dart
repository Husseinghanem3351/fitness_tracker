class DailyCalories {
  final int? id;
  final double eatingCal;
  final double burnedCal;
  final double goalCalories;
  final double protein;
  final double fat;
  final double carb;
  final DateTime? date;

  const DailyCalories({
    this.id,
    required this.eatingCal,
    required this.burnedCal,
    required this.goalCalories,
    required this.protein,
    required this.fat,
    required this.carb,
    this.date,
  });
}
