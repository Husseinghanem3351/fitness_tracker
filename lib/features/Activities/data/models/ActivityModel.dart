import '../../domain/entities/activity.dart';

class ActivityModel extends Activity {
  ActivityModel({
    required super.title,
    required super.titleAr,
    required super.MES,
    super.id,
    required super.name,
    required super.nameAr,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      title: json['title'] ?? '',
      titleAr: json['titleAr'] ?? '',
      MES: json['MES']?.toDouble() ?? 0.0,
      id: json['id'],
      name: json['name'] ?? '',
      nameAr: json['nameAr'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'titleAr': titleAr,
      'MES': MES,
      'name': name,
      'nameAr': nameAr,
    };
  }
}
