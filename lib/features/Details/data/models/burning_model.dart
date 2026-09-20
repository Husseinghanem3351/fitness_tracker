import '../../domain/entities/burning.dart';

class BurningModel extends Burning {
  const BurningModel({
    super.id,
    super.duration,
    super.activityName,
    super.date,
    super.calories,
  });

  factory BurningModel.fromJson(Map<String, dynamic> json) {
    return BurningModel(
      duration: json['duration']?.toDouble() ?? 0.0,
      activityName: json['name'],
      id: json['id'],
      date: json['date'] != null ? DateTime.tryParse(json['date'].toString()) : null,
      calories: json['calories']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'duration': duration,
      'name': activityName,
      'date': date?.toIso8601String(),
      'calories': calories,
    };
  }
}
