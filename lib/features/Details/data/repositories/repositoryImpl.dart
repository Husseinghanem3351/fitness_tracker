import 'package:flutter/material.dart';
import '../../../../global/database.dart';
import '../../../../global/errors/failure.dart';
import '../../domain/entities/burning.dart';
import '../../domain/entities/dailyCalories.dart';
import '../../domain/entities/eating.dart';
import '../../domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';
import '../data_sources/LocalDataSource/sqflite local data source.dart';
import '../models/Calories_inModel.dart';
import '../models/burning_model.dart';

class DetailsRepoImpl implements DetailsRepositories {
  final DetailsLocalDataSource detailsLocalDataSource;

  DetailsRepoImpl({required this.detailsLocalDataSource});

  @override
  Future<Either<Failure, Unit>> addEatingCalories(Eating eating) async {
    try {
      EatingCaloriesModel eatingCaloriesModel = EatingCaloriesModel(
        date: eating.date,
        quantity: eating.quantity,
        calories: eating.calories,
        carb: eating.carb,
        fat: eating.fat,
        mealName: eating.mealName,
        protein: eating.protein,
      );
      await detailsLocalDataSource.insertToEating(eatingCaloriesModel); // Added await
      return const Right(unit);
    } catch (error) {
      return Left(DatabaseNotFound());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteEatingCalories(int id) async {
    try {
      await detailsLocalDataSource.deleteEatingCaloriesData(id); // Added await
      return const Right(unit);
    } catch (error) {
      return Left(DatabaseNotFound());
    }
  }

  @override
  Future<Either<Failure, List<Eating>>> getEatingCalories() async {
    try {
      List<Eating> calories =
          await detailsLocalDataSource.getEatingCaloriesData(database);
      return Right(calories);
    } catch (error) {
      return Left(DatabaseNotFound());
    }
  }

  @override
  Future<Either<Failure, List<Eating>>> searchEatingCaloriesIn(
      DateTimeRange domainDate) async {
    try {
      List<Eating> calories =
          await detailsLocalDataSource.searchEatingCaloriesData(domainDate);
      return Right(calories);
    } catch (error) {
      return Left(DatabaseNotFound());
    }
  }

  @override
  Future<Either<Failure, Unit>> addBurningCalories(Burning burning) async {
    try {
      BurningModel burningModel = BurningModel(
        date: burning.date,
        duration: burning.duration,
        calories: burning.calories,
        activityName: burning.activityName,
      );
      await detailsLocalDataSource.insertToBurning(burningModel); // Added await
      return const Right(unit);
    } catch (error) {
      return Left(DatabaseNotFound());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteBurningCalories(int id) async {
    try {
      await detailsLocalDataSource.deleteBurningCaloriesData(id); // Added await
      return const Right(unit);
    } catch (error) {
      return Left(DatabaseNotFound());
    }
  }

  @override
  Future<Either<Failure, List<Burning>>> getBurningCalories() async {
    try {
      List<Burning> burningCalories =
          await detailsLocalDataSource.getBurningCaloriesData(database);
      return Right(burningCalories);
    } catch (error) {
      return Left(DatabaseNotFound());
    }
  }

  @override
  Future<Either<Failure, List<Burning>>> searchBurningCalories(
      DateTimeRange domainDate) async {
    try {
      List<Burning> burningCalories =
          await detailsLocalDataSource.searchBurningCaloriesData(domainDate);
      return Right(burningCalories);
    } catch (error) {
      return Left(DatabaseNotFound());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCalories() async {
    try {
     await detailsLocalDataSource.updateCalories();
      return const Right(unit);
    } catch (error) {
      return Left(DatabaseNotFound());
    }
  }

  @override
  Future<Either<Failure, List<DailyCalories>>> getDailyCalories() async{
    try{
     List<DailyCalories> dailyCalories= await detailsLocalDataSource.getDailyCaloriesData();
      return Right(dailyCalories);
    }
        catch(error){
      return Left(DatabaseNotFound());
        }
  }
}
