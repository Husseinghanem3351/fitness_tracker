import '../../../../global/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/eating.dart';
import '../repositories/repositories.dart';


class AddEatingCaloriesUseCase{

  DetailsRepositories repository;
  AddEatingCaloriesUseCase({
    required this.repository,
  });

  Future<Either<Failure,Unit>> call(Eating eating) async{
    return await repository.addEatingCalories(eating);
  }
}