class Activity {
  int? id;
  String title;
  String titleAr;
  String name;
  String nameAr;
  double MES;

  Activity({
    required this.MES,
    required this.name,
    required this.nameAr,
    this.id,
    required this.title,
    required this.titleAr,
  });
}
