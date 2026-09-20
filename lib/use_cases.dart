import 'package:dartz/dartz.dart';
import 'package:fitness_tracker/features/Activities/data/data_sources/ActivityLocalDataSource.dart';
import 'package:fitness_tracker/features/Activities/data/repositories/ActivityRepoImpl.dart';
import 'package:fitness_tracker/features/Activities/domain/repositories/ActivityRepository.dart';
import 'package:fitness_tracker/features/Activities/domain/use_cases/activityUseCase/addActivity.dart';
import 'package:fitness_tracker/features/Activities/domain/use_cases/activityUseCase/deleteActivity.dart';
import 'package:fitness_tracker/features/Activities/domain/use_cases/activityUseCase/editActivity.dart';
import 'package:fitness_tracker/features/Activities/domain/use_cases/activityUseCase/getActivityies.dart';
import 'package:fitness_tracker/features/Activities/domain/use_cases/activityUseCase/searchActivity.dart';
import 'package:fitness_tracker/features/Details/data/data_sources/LocalDataSource/sqflite%20local%20data%20source.dart';
import 'package:fitness_tracker/features/Details/data/repositories/repositoryImpl.dart';
import 'package:fitness_tracker/features/Details/domain/entities/dailyCalories.dart';
import 'package:fitness_tracker/features/Details/domain/repositories/repositories.dart';
import 'package:fitness_tracker/features/Details/domain/use_cases/GetDaliyCalories.dart';
import 'package:fitness_tracker/features/Details/domain/use_cases/UpdateCaloriesUseCase.dart';
import 'package:fitness_tracker/features/Details/domain/use_cases/addBurningCaloriesUseCase.dart';
import 'package:fitness_tracker/features/Details/domain/use_cases/addEatngCaloriesUseCase.dart';
import 'package:fitness_tracker/features/Details/domain/use_cases/deleteBurningUseCase.dart';
import 'package:fitness_tracker/features/Details/domain/use_cases/deleteEatingCaloriesUseCase.dart';
import 'package:fitness_tracker/features/Details/domain/use_cases/getBurningCaloriesUseCase.dart';
import 'package:fitness_tracker/features/Details/domain/use_cases/getEatingCaloriesUseCase.dart';
import 'package:fitness_tracker/features/Meals/data/data_sources/LocalDataSource/sqflite%20local%20data%20source.dart';
import 'package:fitness_tracker/features/Meals/data/repositories/repositoryImpl.dart';
import 'package:fitness_tracker/features/Meals/domain/repositories/repositories.dart';
import 'package:fitness_tracker/features/Meals/domain/use_cases/addMeal.dart';
import 'package:fitness_tracker/features/Meals/domain/use_cases/deleteMeal.dart';
import 'package:fitness_tracker/features/Meals/domain/use_cases/getAllMeals.dart';
import 'package:fitness_tracker/features/Meals/domain/use_cases/searchMeal.dart';
import 'package:fitness_tracker/features/Meals/domain/use_cases/updateMeal.dart';
import 'package:fitness_tracker/global/errors/failure.dart';
import 'features/Activities/domain/entities/activity.dart';
import 'features/Details/domain/entities/burning.dart';
import 'features/Details/domain/entities/eating.dart';
import 'features/Meals/domain/entities/meal.dart';

// define the use cases here call it in cubit

class DetailsUseCases {
  static DetailsRepositories detailsRepository =
      DetailsRepoImpl(detailsLocalDataSource: DetailsLocalDataSourceImpl());
  static MealsRepositories mealsRepository =
      MealsRepoImpl(mealLocalDataSource: MealLocalDataSourceImpl());
  static ActivityRepository activityRepository = ActivityRepositoryImpl(
      activityLocalDataSource: ActivityLocalDataSourceImpl());

  static Future<Either<Failure, List<Eating>>> getEatingCalorieUseCase() =>
      GetEatingCaloriesUseCase(repository: detailsRepository)();

 static Future<Either<Failure, List<Burning>>> getBurningCaloriesUseCase() =>
      GetBurningCaloriesUseCase(repository: detailsRepository)();

static  Future<Either<Failure, Unit>> updateCalorieUseCase() =>
      UpdateCaloriesUseCase(repository: detailsRepository)();

 static Future<Either<Failure, List<DailyCalories>>> getDailyCalorieUseCase() =>
      GetDailyCaloriesUseCase(repository: detailsRepository)();

  static Future<Either<Failure, Unit>> addEatingCaloriesUseCase(Eating eating) =>
      AddEatingCaloriesUseCase(repository: detailsRepository)(eating);

  static Future<Either<Failure, Unit>> addBurningCaloriesUseCase(Burning burning) =>
      AddBurningCaloriesUseCase(repository: detailsRepository)(burning);

  static Future<Either<Failure, Unit>> deleteBurningCaloriesUseCase(int id) =>
      DeleteBurningCaloriesUseCase(repository: detailsRepository)(id);

  static Future<Either<Failure, Unit>> deleteEatingCalorieUseCse(int id) =>
      DeleteEatingCaloriesUseCase(repository: detailsRepository)(id);
}

class ActivitiesUseCases {
  static ActivityRepository activityRepository = ActivityRepositoryImpl(
      activityLocalDataSource: ActivityLocalDataSourceImpl());

  static Future<Either<Failure, Unit>> editActivityUseCase(Activity activity) =>
      EditActivityUseCase(repository: activityRepository)(activity);

  static Future<Either<Failure, Unit>> addActivityUseCase(Activity activity) =>
      AddActivityUseCase(repository: activityRepository)(activity);

  static Future<Either<Failure, Unit>> deleteActivityUseCase(int id) =>
      DeleteActivityUseCase(repository: activityRepository)(id);

  static Future<Either<Failure, List<Activity>>> searchActivityUseCase(String name) =>
      SearchActivityUseCase(repository: activityRepository)(name);

  static Future<Either<Failure, List<Activity>>> getActivityUseCase() =>
      GetActivitiesUseCase(repository: activityRepository)();
}

class MealsUseCases {
  static MealsRepositories mealsRepositories =
      MealsRepoImpl(mealLocalDataSource: MealLocalDataSourceImpl());

  static Future<Either<Failure, Unit>> addMealUseCase(Meal meal) => AddMealUseCase(repository: mealsRepositories)(meal);

  static Future<Either<Failure, Unit>> deleteMealUseCase(int id) =>
      DeleteMealUseCase(repository: mealsRepositories)(id);

  static Future<Either<Failure, (List<Meal>, List<Meal>)>> searchMealUseCase(String name) => SearchMealUseCase(repository: mealsRepositories)(name);

  static Future<Either<Failure, (List<Meal>, List<Meal>)>> getMealsUseCase() => GetAllMealsUseCase(repository: mealsRepositories)();

  static Future<Either<Failure, Unit>> updateMealUseCase(Meal meal) =>
      UpdateMealUseCase(repository: mealsRepositories)(meal);
}
