import '../../../../global/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../repositories/repositories.dart';

class AddBurningCaloriesUseCase{

  DetailsRepositories repository;
  AddBurningCaloriesUseCase({
    required this.repository,
  });

  Future<Either<Failure,Unit>> call(burning) async{
    return await repository.addBurningCalories(burning);
  }
}