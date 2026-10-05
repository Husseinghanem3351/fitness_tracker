import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../../global/database.dart';
import '../../../../../global/global.dart';
import '../../../domain/entities/burning.dart';
import '../../../domain/entities/dailyCalories.dart';
import '../../../domain/entities/eating.dart';
import '../../models/Calories_inModel.dart';
import '../../models/burning_model.dart';
import '../../models/dailyCaloriesModel.dart';

abstract class DetailsLocalDataSource {
  Future<Unit> deleteEatingCaloriesData(int id);
  Future<List<Eating>> getEatingCaloriesData(Database database);
  Future<Unit> insertToEating(EatingCaloriesModel eatingCaloriesModel);
  Future<List<Eating>> searchEatingCaloriesData(DateTimeRange dateTimeRange);
  Future<Unit> deleteBurningCaloriesData(int id);
  Future<List<Burning>> getBurningCaloriesData(Database database);
  Future<Unit> insertToBurning(BurningModel burningModel);
  Future<Unit> updateCalories();
  Future<List<Burning>> searchBurningCaloriesData(DateTimeRange dateTimeRange);
  Future<List<DailyCalories>> getDailyCaloriesData();
}

class DetailsLocalDataSourceImpl implements DetailsLocalDataSource {
  @override
  Future<List<Eating>> getEatingCaloriesData(Database database) async {
    try {
      List<Map<String, Object?>> eating = await database.rawQuery('select * from eating');
      return eating.map<Eating>((e) => EatingCaloriesModel.fromJson(e)).toList();
    } catch (error) {
      throw Exception('Database Error');
    }
  }

  @override
  Future<Unit> insertToEating(EatingCaloriesModel eatingCaloriesModel) async {
    try {
      await database.transaction((txn) => txn.insert('eating', eatingCaloriesModel.toJson()));
      return unit;
    } catch (error) {
      throw Exception('Database Error');
    }
  }

  @override
  Future<Unit> deleteEatingCaloriesData(int id) async {
    try {
      await database.rawDelete('delete from eating where id =$id');
      return unit;
    } catch (error) {
      throw Exception('Database Error');
    }
  }

  @override
  Future<List<Eating>> searchEatingCaloriesData(DateTimeRange range) async {
    try {
      final value = await database.rawQuery(
          'select * from eating where DATE(date) >=? And DATE(date)<= ?',
          [range.start.toIso8601String(), range.end.toIso8601String()]);
      return value.map<EatingCaloriesModel>((e) => EatingCaloriesModel.fromJson(e)).toList();
    } catch (error) {
      throw Exception('Database Error');
    }
  }

  @override
  Future<Unit> updateCalories() async {
    String currentDate = DateTime.now().toIso8601String().substring(0, 10);

    DailyCaloriesModel dailyCaloriesModel = DailyCaloriesModel(
      goalCalories: dailyGoalCalories,
      eatingCal: eatingCalories,
      burnedCal: burningCalories,
      date: DateTime.now(),
      fat: eatingFat,
      protein: eatingProtein,
      carb: eatingCarb,
    );

    try {
      // Use INSERT OR REPLACE to ensure only one record exists per day
      // The 'date' column has a UNIQUE constraint in version 3 of the DB
      await database.insert(
        'dailyCalories',
        dailyCaloriesModel.toUpdateJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Database synced for date: $currentDate');
    } catch (error) {
      print('Update statistics error: $error');
    }
    return unit;
  }

  @override
  Future<List<Burning>> getBurningCaloriesData(Database database) async {
    try {
      List<Map<String, Object?>> burning = await database.rawQuery('select * from burning');
      return burning.map<Burning>((e) => BurningModel.fromJson(e)).toList();
    } catch (error) {
      throw Exception('Database Error');
    }
  }

  @override
  Future<Unit> insertToBurning(BurningModel burningModel) async {
    try {
      await database.insert('burning', burningModel.toJson());
      return unit;
    } catch (error) {
      throw Exception('Database Error');
    }
  }

  @override
  Future<Unit> deleteBurningCaloriesData(int id) async {
    try {
      await database.rawDelete('delete from burning where id =$id');
      return unit;
    } catch (error) {
      throw Exception('Database Error');
    }
  }

  @override
  Future<List<Burning>> searchBurningCaloriesData(DateTimeRange range) async {
    try {
      final value = await database.rawQuery(
          'select * from burning where DATE(date) >=? And DATE(date)<= ?',
          [range.start.toIso8601String(), range.end.toIso8601String()]);
      return value.map<BurningModel>((e) => BurningModel.fromJson(e)).toList();
    } catch (error) {
      throw Exception('Database Error');
    }
  }

  @override
  Future<List<DailyCalories>> getDailyCaloriesData() async {
    try {
      List<Map<String, Object?>> data =
          await database.rawQuery('select * from dailyCalories ORDER by date DESC');
      return data.map<DailyCaloriesModel>((e) => DailyCaloriesModel.fromJson(e)).toList();
    } catch (error) {
      throw Exception('Database Error');
    }
  }
}
