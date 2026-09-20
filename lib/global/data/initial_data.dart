import '../../features/Meals/data/models/meal.dart';
import '../../features/Activities/data/models/ActivityModel.dart';

List<ActivityModel> initialActivities = [
  // WALKING
  ActivityModel(title: "Walking", titleAr: "مشي", name: "Walking, 2.0 mph, slow pace", nameAr: "مشي، 2.0 ميل/سا، وتيرة بطيئة", MES: 2.8),
  ActivityModel(title: "Walking", titleAr: "مشي", name: "Walking, 3.0 mph, moderate pace", nameAr: "مشي، 3.0 ميل/سا، وتيرة معتدلة", MES: 3.5),
  ActivityModel(title: "Walking", titleAr: "مشي", name: "Walking, 3.5 mph, brisk pace", nameAr: "مشي، 3.5 ميل/سا، وتيرة سريعة", MES: 4.3),
  ActivityModel(title: "Walking", titleAr: "مشي", name: "Walking, 4.0 mph, very brisk pace", nameAr: "مشي، 4.0 ميل/سا، وتيرة سريعة جداً", MES: 5.0),
  ActivityModel(title: "Walking", titleAr: "مشي", name: "Walking the dog", nameAr: "مشي مع الكلب", MES: 3.0),
  ActivityModel(title: "Walking", titleAr: "مشي", name: "Hiking, cross country", nameAr: "تنزه خلوى، عبر البلاد", MES: 6.0),
  ActivityModel(title: "Walking", titleAr: "مشي", name: "Stair climbing, slow pace", nameAr: "صعود الدرج، وتيرة بطيئة", MES: 4.0),
  ActivityModel(title: "Walking", titleAr: "مشي", name: "Stair climbing, fast pace", nameAr: "صعود الدرج، وتيرة سريعة", MES: 8.8),

  // RUNNING
  ActivityModel(title: "Running", titleAr: "جري", name: "Jogging, general", nameAr: "هرولة، عامة", MES: 7.0),
  ActivityModel(title: "Running", titleAr: "جري", name: "Running, 5 mph (12 min/mile)", nameAr: "جري، 5 ميل/سا (12 د/ميل)", MES: 8.3),
  ActivityModel(title: "Running", titleAr: "جري", name: "Running, 6 mph (10 min/mile)", nameAr: "جري، 6 ميل/سا (10 د/ميل)", MES: 9.8),
  ActivityModel(title: "Running", titleAr: "جري", name: "Running, 7 mph (8.5 min/mile)", nameAr: "جري، 7 ميل/سا (8.5 د/ميل)", MES: 11.0),
  ActivityModel(title: "Running", titleAr: "جري", name: "Running, 8 mph (7.5 min/mile)", nameAr: "جري، 8 ميل/سا (7.5 د/ميل)", MES: 11.8),
  ActivityModel(title: "Running", titleAr: "جري", name: "Running, 9 mph (6.5 min/mile)", nameAr: "جري، 9 ميل/سا (6.5 د/ميل)", MES: 12.8),
  ActivityModel(title: "Running", titleAr: "جري", name: "Running, 10 mph (6 min/mile)", nameAr: "جري، 10 ميل/سا (6 د/ميل)", MES: 14.5),
  ActivityModel(title: "Running", titleAr: "جري", name: "Running, stairs, up", nameAr: "جري، صعود الدرج", MES: 15.0),

  // CYCLING
  ActivityModel(title: "Cycling", titleAr: "ركوب دراجة", name: "Bicycling, <10 mph, leisure", nameAr: "ركوب دراجة، <10 ميل/سا، تترفيهي", MES: 4.0),
  ActivityModel(title: "Cycling", titleAr: "ركوب دراجة", name: "Bicycling, 10-11.9 mph, slow", nameAr: "ركوب دراجة، 10-11.9 ميل/سا، بطيء", MES: 6.8),
  ActivityModel(title: "Cycling", titleAr: "ركوب دراجة", name: "Bicycling, 12-13.9 mph, moderate", nameAr: "ركوب دراجة، 12-13.9 ميل/سا، معتدل", MES: 8.0),
  ActivityModel(title: "Cycling", titleAr: "ركوب دراجة", name: "Bicycling, 14-15.9 mph, vigorous", nameAr: "ركوب دراجة، 14-15.9 ميل/سا، قوي", MES: 10.0),
  ActivityModel(title: "Cycling", titleAr: "ركوب دراجة", name: "Bicycling, stationary, general", nameAr: "ركوب دراجة ثابتة، عام", MES: 7.0),

  // GYM & CONDITIONING
  ActivityModel(title: "Gym", titleAr: "نادي رياضي", name: "Resistance training, weight lifting, vigorous", nameAr: "تمارين مقاومة، رفع أثقال، قوي", MES: 6.0),
  ActivityModel(title: "Gym", titleAr: "نادي رياضي", name: "Resistance training, moderate", nameAr: "تمارين مقاومة، معتدل", MES: 3.5),
  ActivityModel(title: "Gym", titleAr: "نادي رياضي", name: "Push ups, sit ups, pull-ups, vigorous", nameAr: "ضغط، بطن، عقلة، قوي", MES: 8.0),
  ActivityModel(title: "Gym", titleAr: "نادي رياضي", name: "Elliptical trainer, moderate", nameAr: "جهاز اليبتيكال، معتدل", MES: 5.0),
  ActivityModel(title: "Gym", titleAr: "نادي رياضي", name: "Rowing, stationary, moderate", nameAr: "تجذيف ثابت، معتدل", MES: 4.8),
  ActivityModel(title: "Gym", titleAr: "نادي رياضي", name: "Circuit training, vigorous", nameAr: "تمارين دائرية، قوي", MES: 8.0),
  ActivityModel(title: "Gym", titleAr: "نادي رياضي", name: "Aerobics, general", nameAr: "أيروبيك، عام", MES: 7.3),

  // SPORTS
  ActivityModel(title: "Sports", titleAr: "رياضة", name: "Swimming laps, freestyle, moderate", nameAr: "سباحة، سباحة حرة، معتدل", MES: 5.8),
  ActivityModel(title: "Sports", titleAr: "رياضة", name: "Swimming laps, freestyle, fast", nameAr: "سباحة، سباحة حرة، سريع", MES: 9.8),
  ActivityModel(title: "Sports", titleAr: "رياضة", name: "Basketball, game", nameAr: "كرة سلة، مباراة", MES: 8.0),
  ActivityModel(title: "Sports", titleAr: "رياضة", name: "Soccer, casual", nameAr: "كرة قدم، ترفيهي", MES: 7.0),
  ActivityModel(title: "Sports", titleAr: "رياضة", name: "Tennis, singles", nameAr: "تنس، فردي", MES: 8.0),
  ActivityModel(title: "Sports", titleAr: "رياضة", name: "Volleyball, competitive", nameAr: "كرة طائرة، تنافسي", MES: 6.0),
  ActivityModel(title: "Sports", titleAr: "رياضة", name: "Football, touch/flag", nameAr: "كرة قدم أمريكية، لمس", MES: 8.0),

  // FLEXIBILITY & CALM
  ActivityModel(title: "Flexibility", titleAr: "مرونة", name: "Yoga, Hatha", nameAr: "يوغا، هاثا", MES: 2.5),
  ActivityModel(title: "Flexibility", titleAr: "مرونة", name: "Yoga, Power", nameAr: "يوغا، باور", MES: 4.0),
  ActivityModel(title: "Flexibility", titleAr: "مرونة", name: "Stretching, mild", nameAr: "تمارين تمدد، خفيف", MES: 2.3),
  ActivityModel(title: "Flexibility", titleAr: "مرونة", name: "Pilates, general", nameAr: "بيلاتس، عام", MES: 3.0),
  ActivityModel(title: "Flexibility", titleAr: "مرونة", name: "Tai chi, general", nameAr: "تاي تشي، عام", MES: 3.0),
];

List<MealModel> basicMeals = [
  // CARBOHYDRATES / GRAINS (per 100g cooked)
  const MealModel(name: 'Boiled Rice (White)', nameAr: 'أرز مسلوق (أبيض)', calories: 130, protein: 2.7, carb: 28, fat: 0.3, defaultValue: 150, defaultValueName: '1 Glass'),
  const MealModel(name: 'Brown Rice', nameAr: 'أرز بني', calories: 111, protein: 2.6, carb: 23, fat: 0.9, defaultValue: 150, defaultValueName: '1 Glass'),
  const MealModel(name: 'Pasta (Spaghetti)', nameAr: 'معكرونة (سباغيتي)', calories: 158, protein: 5.8, carb: 31, fat: 0.9, defaultValue: 150, defaultValueName: '1 Plate'),
  const MealModel(name: 'Oats (Cooked in water)', nameAr: 'شوفان (مطبوخ بالماء)', calories: 71, protein: 2.5, carb: 12, fat: 1.4, defaultValue: 40, defaultValueName: '1/2 Cup'),
  const MealModel(name: 'Bread (White, 1 slice)', nameAr: 'خبز (أبيض، شريحة واحدة)', calories: 75, protein: 2.0, carb: 15, fat: 1.0, defaultValue: 30, defaultValueName: '1 Slice'),
  const MealModel(name: 'Bread (Whole Wheat, 1 slice)', nameAr: 'خبز (قمح كامل، شريحة واحدة)', calories: 69, protein: 3.5, carb: 12, fat: 0.9, defaultValue: 30, defaultValueName: '1 Slice'),
  const MealModel(name: 'Potato (Boiled)', nameAr: 'بطاطا (مسلوقة)', calories: 87, protein: 1.9, carb: 20, fat: 0.1, defaultValue: 150, defaultValueName: '1 Medium'),
  const MealModel(name: 'Sweet Potato (Baked)', nameAr: 'بطاطا حلوة (مشوية)', calories: 86, protein: 1.6, carb: 20, fat: 0.1, defaultValue: 150, defaultValueName: '1 Medium'),
  const MealModel(name: 'Quinoa (Cooked)', nameAr: 'كينوا (مطبوخة)', calories: 120, protein: 4.4, carb: 21, fat: 1.9, defaultValue: 150, defaultValueName: '1 Cup'),
  const MealModel(name: 'Corn (Sweet, Boiled)', nameAr: 'ذرة (حلوة، مسلوقة)', calories: 96, protein: 3.4, carb: 21, fat: 1.5, defaultValue: 100, defaultValueName: '1 Piece'),
  const MealModel(name: 'Pancakes (Healthy)', nameAr: 'بانكيك (صحي)', calories: 227, protein: 6.4, carb: 28, fat: 9.7, defaultValue: 45, defaultValueName: '1 Piece'),
  const MealModel(name: 'Arabic Bread (Pita)', nameAr: 'خبز عربي (بيتا)', calories: 275, protein: 9.0, carb: 55, fat: 1.2, defaultValue: 60, defaultValueName: '1 Loaf'),

  // PROTEINS (per 100g cooked)
  const MealModel(name: 'Chicken Breast (Grilled)', nameAr: 'صدر دجاج (مشوي)', calories: 165, protein: 31, carb: 0, fat: 3.6, defaultValue: 150, defaultValueName: '1 Piece'),
  const MealModel(name: 'Chicken Thigh (Grilled)', nameAr: 'فخذ دجاج (مشوي)', calories: 209, protein: 26, carb: 0, fat: 11, defaultValue: 100, defaultValueName: '1 Piece'),
  const MealModel(name: 'Egg (Large, Boiled)', nameAr: 'بيضة (كبيرة، مسلوقة)', calories: 78, protein: 6.3, carb: 0.6, fat: 5.3, defaultValue: 50, defaultValueName: '1 Egg'),
  const MealModel(name: 'Egg (Omelet)', nameAr: 'أومليت بيض', calories: 154, protein: 11, carb: 0.6, fat: 12, defaultValue: 60, defaultValueName: '1 Egg'),
  const MealModel(name: 'Salmon (Grilled)', nameAr: 'سلمون (مشوي)', calories: 208, protein: 20, carb: 0, fat: 13, defaultValue: 150, defaultValueName: '1 Piece'),
  const MealModel(name: 'Tuna (Canned in water)', nameAr: 'تونة (معلبة بالماء)', calories: 116, protein: 26, carb: 0, fat: 0.8, defaultValue: 160, defaultValueName: '1 Can'),
  const MealModel(name: 'Beef Steak (Sirloin)', nameAr: 'ستيك بقري (سيرلوين)', calories: 250, protein: 27, carb: 0, fat: 15, defaultValue: 200, defaultValueName: '1 Piece'),
  const MealModel(name: 'Lentils (Boiled)', nameAr: 'عدس (مسلوق)', calories: 116, protein: 9.0, carb: 20, fat: 0.4, defaultValue: 200, defaultValueName: '1 Bowl'),
  const MealModel(name: 'Greek Yogurt (Plain)', nameAr: 'لبن زبادي يوناني', calories: 59, protein: 10, carb: 3.6, fat: 0.4, defaultValue: 170, defaultValueName: '1 Cup'),
  const MealModel(name: 'Tofu (Firm)', nameAr: 'توفو (قاسي)', calories: 144, protein: 16, carb: 3.9, fat: 8.7, defaultValue: 100, defaultValueName: '1 Block'),
  const MealModel(name: 'Turkey Breast (Roasted)', nameAr: 'صدر حبش (مشوي)', calories: 135, protein: 30, carb: 0, fat: 0.7, defaultValue: 100, defaultValueName: '1 Slice'),
  const MealModel(name: 'Shrimp (Steamed)', nameAr: 'قريدس (مطهو على البخار)', calories: 99, protein: 24, carb: 0, fat: 0.3, defaultValue: 10, defaultValueName: '1 Piece'),
  const MealModel(name: 'Ful Medames (Fava Beans)', nameAr: 'فول مدمس', calories: 110, protein: 7.6, carb: 17, fat: 0.5, defaultValue: 200, defaultValueName: '1 Bowl'),
  const MealModel(name: 'Chickpeas (Boiled)', nameAr: 'حمص (مسلوق)', calories: 164, protein: 8.9, carb: 27, fat: 2.6, defaultValue: 150, defaultValueName: '1 Cup'),

  // DAIRY & ALTERNATIVES (per 100g/ml)
  const MealModel(name: 'Milk (Full Fat)', nameAr: 'حليب (كامل الدسم)', calories: 61, protein: 3.3, carb: 4.8, fat: 3.3, defaultValue: 240, defaultValueName: '1 Cup'),
  const MealModel(name: 'Milk (Skimmed)', nameAr: 'حليب (خالي الدسم)', calories: 34, protein: 3.4, carb: 5.0, fat: 0.1, defaultValue: 240, defaultValueName: '1 Cup'),
  const MealModel(name: 'Cheddar Cheese', nameAr: 'جبنة شيدر', calories: 402, protein: 25, carb: 1.3, fat: 33, defaultValue: 28, defaultValueName: '1 Slice'),
  const MealModel(name: 'Feta Cheese', nameAr: 'جبنة فيتا', calories: 264, protein: 14, carb: 4.1, fat: 21, defaultValue: 30, defaultValueName: '1 Cube'),
  const MealModel(name: 'Cottage Cheese', nameAr: 'جبنة قريش', calories: 98, protein: 11, carb: 3.4, fat: 4.3, defaultValue: 110, defaultValueName: '1/2 Cup'),
  const MealModel(name: 'Labneh', nameAr: 'لبنة', calories: 154, protein: 9.0, carb: 3.7, fat: 12, defaultValue: 30, defaultValueName: '2 Tbsp'),

  // FRUITS & VEGETABLES (per 100g)
  const MealModel(name: 'Banana', nameAr: 'موز', calories: 89, protein: 1.1, carb: 23, fat: 0.3, defaultValue: 120, defaultValueName: '1 Medium'),
  const MealModel(name: 'Apple', nameAr: 'تفاح', calories: 52, protein: 0.3, carb: 14, fat: 0.2, defaultValue: 150, defaultValueName: '1 Medium'),
  const MealModel(name: 'Avocado', nameAr: 'أفوكادو', calories: 160, protein: 2.0, carb: 8.5, fat: 15, defaultValue: 50, defaultValueName: '1/2 Medium'),
  const MealModel(name: 'Broccoli (Steamed)', nameAr: 'بروكلي (مطهو على البخار)', calories: 34, protein: 2.8, carb: 7.0, fat: 0.4, defaultValue: 100, defaultValueName: '1 Cup'),
  const MealModel(name: 'Spinach (Cooked)', nameAr: 'سبانخ (مطبوخة)', calories: 23, protein: 3.0, carb: 3.6, fat: 0.3, defaultValue: 100, defaultValueName: '1 Cup'),
  const MealModel(name: 'Cucumber', nameAr: 'خيار', calories: 15, protein: 0.7, carb: 3.6, fat: 0.1, defaultValue: 100, defaultValueName: '1 Piece'),
  const MealModel(name: 'Tomato', nameAr: 'بندورة', calories: 18, protein: 0.9, carb: 3.9, fat: 0.2, defaultValue: 100, defaultValueName: '1 Medium'),
  const MealModel(name: 'Carrot (Raw)', nameAr: 'جزر', calories: 41, protein: 0.9, carb: 10, fat: 0.2, defaultValue: 60, defaultValueName: '1 Medium'),
  const MealModel(name: 'Orange', nameAr: 'برتقال', calories: 47, protein: 0.9, carb: 12, fat: 0.1, defaultValue: 130, defaultValueName: '1 Medium'),
  const MealModel(name: 'Strawberries', nameAr: 'فراولة', calories: 32, protein: 0.7, carb: 7.7, fat: 0.3, defaultValue: 15, defaultValueName: '1 Piece'),
  const MealModel(name: 'Blueberries', nameAr: 'توت أزرق', calories: 57, protein: 0.7, carb: 14, fat: 0.3, defaultValue: 1, defaultValueName: '1 Berry'),
  const MealModel(name: 'Mixed Salad', nameAr: 'سلطة مشكلة', calories: 20, protein: 1.2, carb: 3.0, fat: 0.2, defaultValue: 200, defaultValueName: '1 Bowl'),

  // OTHERS / FATS / NUTS
  const MealModel(name: 'Peanut Butter', nameAr: 'زبدة الفول السوداني', calories: 588, protein: 25, carb: 20, fat: 50, defaultValue: 16, defaultValueName: '1 Tbsp'),
  const MealModel(name: 'Olive Oil (1 tbsp)', nameAr: 'زيت زيتون (1 ملعقة كبيرة)', calories: 119, protein: 0, carb: 0, fat: 14, defaultValue: 14, defaultValueName: '1 Tbsp'),
  const MealModel(name: 'Butter', nameAr: 'زبدة', calories: 717, protein: 0.9, carb: 0.1, fat: 81, defaultValue: 5, defaultValueName: '1 tsp'),
  const MealModel(name: 'Sugar (1 tsp)', nameAr: 'سكر (1 ملعقة صغيرة)', calories: 16, protein: 0, carb: 4.0, fat: 0, defaultValue: 4, defaultValueName: '1 tsp'),
  const MealModel(name: 'Almonds', nameAr: 'لوز', calories: 579, protein: 21, carb: 22, fat: 49, defaultValue: 15, defaultValueName: '10 Nuts'),
  const MealModel(name: 'Walnuts', nameAr: 'جوز', calories: 654, protein: 15, carb: 14, fat: 65, defaultValue: 15, defaultValueName: '5 Nuts'),
  const MealModel(name: 'Hummus', nameAr: 'حمص بطحينة', calories: 166, protein: 7.9, carb: 14, fat: 9.6, defaultValue: 60, defaultValueName: '1 Bowl'),
  const MealModel(name: 'Dark Chocolate (70%)', nameAr: 'شوكولاتة داكنة (70%)', calories: 546, protein: 4.9, carb: 46, fat: 31, defaultValue: 20, defaultValueName: '2 Squares'),
  const MealModel(name: 'Honey (1 tbsp)', nameAr: 'عسل (ملعقة كبيرة)', calories: 64, protein: 0.1, carb: 17, fat: 0, defaultValue: 21, defaultValueName: '1 Tbsp'),
  const MealModel(name: 'Strawberry Jam', nameAr: 'مربى فراولة', calories: 278, protein: 0.4, carb: 69, fat: 0.1, defaultValue: 20, defaultValueName: '1 Tbsp'),
  const MealModel(name: 'Dates', nameAr: 'تمر', calories: 282, protein: 2.5, carb: 75, fat: 0.4, defaultValue: 24, defaultValueName: '3 Pieces'),
  const MealModel(name: 'Popcorn (Air-popped)', nameAr: 'بشار (بدون زيت)', calories: 387, protein: 13, carb: 78, fat: 5, defaultValue: 24, defaultValueName: '3 Cups'),
  const MealModel(name: 'Rice Cakes', nameAr: 'كعك الأرز', calories: 387, protein: 8, carb: 82, fat: 3, defaultValue: 18, defaultValueName: '2 Cakes'),
  const MealModel(name: 'Zaatar', nameAr: 'زعتر', calories: 443, protein: 9, carb: 20, fat: 38, defaultValue: 10, defaultValueName: '1 Tbsp'),
  const MealModel(name: 'Olive (Green)', nameAr: 'زيتون أخضر', calories: 145, protein: 1, carb: 4, fat: 15, defaultValue: 15, defaultValueName: '5 Pieces'),
  const MealModel(name: 'Halloumi Cheese', nameAr: 'جبنة حلوم', calories: 320, protein: 21, carb: 2, fat: 26, defaultValue: 50, defaultValueName: '2 Slices'),
  const MealModel(name: 'Tuna (Canned)', nameAr: 'تونة (معلبة)', calories: 116, protein: 26, carb: 0, fat: 0.8, defaultValue: 160, defaultValueName: '1 Can'),
  const MealModel(name: 'Sardines (Canned)', nameAr: 'سردين (معلب)', calories: 208, protein: 25, carb: 0, fat: 11, defaultValue: 100, defaultValueName: '1 Can'),
  const MealModel(name: 'Manakish Zaatar', nameAr: 'منقوشة زعتر', calories: 250, protein: 8, carb: 35, fat: 12, defaultValue: 100, defaultValueName: '1 Piece'),
  const MealModel(name: 'Falafel', nameAr: 'فلافل', calories: 333, protein: 13, carb: 32, fat: 17, defaultValue: 25, defaultValueName: '1 Piece'),
];

