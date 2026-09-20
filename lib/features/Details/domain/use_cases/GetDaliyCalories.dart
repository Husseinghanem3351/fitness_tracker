import '../../../../global/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/dailyCalories.dart';
import '../repositories/repositories.dart';

class GetDailyCaloriesUseCase{

  DetailsRepositories repository;
  GetDailyCaloriesUseCase({
    required this.repository,
  });

  Future<Either<Failure,List<DailyCalories>>> call() async{
    return await repository.getDailyCalories();
  }
}