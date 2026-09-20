import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import '../generated/l10n.dart';
import 'database.dart';
import 'data/initial_data.dart';

void navigateTo(BuildContext context, Widget screen) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ));
}

void navigateAndFinish(BuildContext context, Widget screen) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
      (route) => false);
}

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

String? validatorMethod(String? value, BuildContext context) {
  if (value!.isEmpty) return S.of(context).validationMessage;
  return null;
}

Future<Unit> createDatabase() async {
  print('Creating database...');
  try {
    database = await openDatabase(
      'meals.db',
      version: 4, // Bumped to 4 to fix custom meals table schema
      onConfigure: (database) {},
      onCreate: (
        database,
        version,
      ) {
        database.execute(
          'drop table if exists eating',
        );
        database.execute(
          'create table if not exists eating(id integer primary key, name text,quantity Real,calories double,date text,fat double,carb double, protein double)',
        );
        database.execute(
          'drop table if exists burning',
        );
        database.execute(
          'create table if not exists burning(id integer primary key, date text,name text,calories double,duration Real )',
        );
        database.execute(
          'drop table if exists basicMeals',
        );
        database.execute(
          'create table if not exists basicMeals(id integer primary key, name text, nameAr text, calories double,protein double,carb double,fat double,defaultQuantity double,nameDefaultQuantity text)',
        );
        database.execute(
          'drop table if exists meals',
        );
        database.execute(
          'create table if not exists meals(id integer primary key, name text, nameAr text, calories double,protein double,carb double,fat double,defaultQuantity double,nameDefaultQuantity text)',
        );
        database.execute(
          'drop table if exists activities',
        );
        database.execute(
          'create table if not exists activities(id integer primary key, name text, nameAr text, title text, titleAr text, MES Real)',
        );
        database.execute(
          'drop table if exists dailyCalories',
        );
        database.execute(
          'create table if not exists dailyCalories(id integer primary key, eatingCal Real,burnedCal Real, goalCalories Real,date text UNIQUE,fat Real,protein Real,carb Real)',
        );
        for (var meal in basicMeals) {
          database.insert('basicMeals', meal.toJson());
        }
        for (var activity in initialActivities) {
          database.insert('activities', activity.toJson());
        }
      },
      onUpgrade: (database, oldVersion, newVersion) async {
        if (oldVersion < 3) {
           await database.execute('DROP TABLE IF EXISTS dailyCalories');
           await database.execute(
             'create table if not exists dailyCalories(id integer primary key, eatingCal Real,burnedCal Real, goalCalories Real,date text UNIQUE,fat Real,protein Real,carb Real)',
           );
        }
        if (oldVersion < 4) {
           // Fix the 'meals' table for custom user meals
           await database.execute('DROP TABLE IF EXISTS meals');
           await database.execute(
             'create table if not exists meals(id integer primary key, name text, nameAr text, calories double,protein double,carb double,fat double,defaultQuantity double,nameDefaultQuantity text)',
           );
        }
        // General refresh for other tables if needed
        await database.execute('DROP TABLE IF EXISTS basicMeals');
        await database.execute('DROP TABLE IF EXISTS activities');
        await database.execute(
          'create table if not exists basicMeals(id integer primary key, name text, nameAr text, calories double,protein double,carb double,fat double,defaultQuantity double,nameDefaultQuantity text)',
        );
        await database.execute(
          'create table if not exists activities(id integer primary key, name text, nameAr text, title text, titleAr text, MES Real)',
        );
        for (var activity in initialActivities) {
          await database.insert('activities', activity.toJson());
        }
        for (var meal in basicMeals) {
          await database.insert('basicMeals', meal.toJson());
        }
      },
      onOpen: (database) async {},
    );
  } catch (error) {
    print(error);
  }
  return Future.value(unit);
}

Future<Unit> deleteOldDate() {
  Timer(
    const Duration(days: 1),
    () async {
      var eatingCalories = await database.rawQuery('select * from eating');
      for (int i = 0; i < eatingCalories.length; i++) {
        if (DateTime.now()
                .difference(
                    DateTime.parse(eatingCalories[i]['date'].toString()))
                .inDays >
            7) {
          database.rawQuery(
              'delete from eating where id =${eatingCalories[i]['id']}');
        }
      }
      var burningCalories = await database.rawQuery('select * from burning');
      for (int i = 0; i < burningCalories.length; i++) {
        if (DateTime.now()
                .difference(
                    DateTime.parse(burningCalories[i]['date'].toString()))
                .inDays >
            7) {
          database.rawQuery(
              'delete from burning where id =${burningCalories[i]['id']}');
        }
      }
    },
  );
  return Future.value(unit);
}