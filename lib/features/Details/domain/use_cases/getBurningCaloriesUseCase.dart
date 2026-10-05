import 'package:dartz/dartz.dart';
import '../../../../global/errors/failure.dart';
import '../entities/burning.dart';
import '../repositories/repositories.dart';

class GetBurningCaloriesUseCase {
  DetailsRepositories repository;
  GetBurningCaloriesUseCase({required this.repository});

  Future<Either<Failure,List<Burning>>> call()async{
    return await repository.getBurningCalories();
  }
}