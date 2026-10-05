class PersonalInfoModel {
  final double height;
  final double weight;
  final double age;
  final String gender;
  final String name;
  final String dietType; // Added field

  PersonalInfoModel({
    required this.height,
    required this.weight,
    required this.age,
    required this.gender,
    required this.name,
    this.dietType = 'Standard', // Default value
  });

  Map<String, dynamic> toJson() {
    return {
      'height': height,
      'weight': weight,
      'age': age,
      'gender': gender,
      'name': name,
      'dietType': dietType,
    };
  }

  factory PersonalInfoModel.fromJson(Map<String, dynamic> json) {
    return PersonalInfoModel(
      height: json['height']?.toDouble() ?? 0.0,
      weight: json['weight']?.toDouble() ?? 0.0,
      age: json['age']?.toDouble() ?? 0.0,
      gender: json['gender'] ?? '',
      name: json['name'] ?? '',
      dietType: json['dietType'] ?? 'Standard',
    );
  }
}
