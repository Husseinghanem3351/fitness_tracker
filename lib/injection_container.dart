import 'package:get_it/get_it.dart';
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
import 'package:fitness_tracker/features/Activities/presentation/bloc/ActivitiesBloc/cubit.dart';
import 'package:fitness_tracker/features/Details/presentation/bloc/cubit.dart';
import 'package:fitness_tracker/features/Meals/presentation/bloc/MealsCubit/MealsCubit.dart';
import 'package:fitness_tracker/features/Home/presentation/cubit/cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubits
  sl.registerFactory(() => ActivitiesCubit(
        addActivityUseCase: sl(),
        deleteActivityUseCase: sl(),
        editActivityUseCase: sl(),
        getActivitiesUseCase: sl(),
        searchActivityUseCase: sl(),
      ));
  sl.registerFactory(() => DetailsCubit(
        addBurningCaloriesUseCase: sl(),
        addEatingCaloriesUseCase: sl(),
        deleteBurningCaloriesUseCase: sl(),
        deleteEatingCaloriesUseCase: sl(),
        getBurningCaloriesUseCase: sl(),
        getDailyCaloriesUseCase: sl(),
        getEatingCaloriesUseCase: sl(),
        updateCaloriesUseCase: sl(),
      ));
  sl.registerFactory(() => MealsCubit(
        addMealUseCase: sl(),
        deleteMealUseCase: sl(),
        getAllMealsUseCase: sl(),
        searchMealUseCase: sl(),
        updateMealUseCase: sl(),
      ));
  sl.registerFactory(() => HomeCubit());

  // Use cases
  // Activities
  sl.registerLazySingleton(() => AddActivityUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteActivityUseCase(repository: sl()));
  sl.registerLazySingleton(() => EditActivityUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetActivitiesUseCase(repository: sl()));
  sl.registerLazySingleton(() => SearchActivityUseCase(repository: sl()));

  // Details
  sl.registerLazySingleton(() => AddBurningCaloriesUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddEatingCaloriesUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteBurningCaloriesUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteEatingCaloriesUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetBurningCaloriesUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetDailyCaloriesUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetEatingCaloriesUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateCaloriesUseCase(repository: sl()));

  // Meals
  sl.registerLazySingleton(() => AddMealUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteMealUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAllMealsUseCase(repository: sl()));
  sl.registerLazySingleton(() => SearchMealUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateMealUseCase(repository: sl()));

  // Repositories
  sl.registerLazySingleton<ActivityRepository>(
      () => ActivityRepositoryImpl(activityLocalDataSource: sl()));
  sl.registerLazySingleton<DetailsRepositories>(
      () => DetailsRepoImpl(detailsLocalDataSource: sl()));
  sl.registerLazySingleton<MealsRepositories>(
      () => MealsRepoImpl(mealLocalDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<ActivityLocalDataSource>(
      () => ActivityLocalDataSourceImpl());
  sl.registerLazySingleton<DetailsLocalDataSource>(
      () => DetailsLocalDataSourceImpl());
  sl.registerLazySingleton<MealLocalDataSource>(
      () => MealLocalDataSourceImpl());
}
