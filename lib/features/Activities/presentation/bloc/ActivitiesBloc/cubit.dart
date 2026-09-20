import 'package:fitness_tracker/features/Activities/presentation/bloc/ActivitiesBloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../global/errors/failure.dart';
import '../../../../../global/strings/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../domain/entities/activity.dart';
import '../../../domain/use_cases/activityUseCase/addActivity.dart';
import '../../../domain/use_cases/activityUseCase/deleteActivity.dart';
import '../../../domain/use_cases/activityUseCase/editActivity.dart';
import '../../../domain/use_cases/activityUseCase/getActivityies.dart';
import '../../../domain/use_cases/activityUseCase/searchActivity.dart';

class ActivitiesCubit extends Cubit<ActivitiesStates> {
  final AddActivityUseCase addActivityUseCase;
  final DeleteActivityUseCase deleteActivityUseCase;
  final EditActivityUseCase editActivityUseCase;
  final GetActivitiesUseCase getActivitiesUseCase;
  final SearchActivityUseCase searchActivityUseCase;

  ActivitiesCubit({
    required this.addActivityUseCase,
    required this.deleteActivityUseCase,
    required this.editActivityUseCase,
    required this.getActivitiesUseCase,
    required this.searchActivityUseCase,
  }) : super(InitActivitiesState());


  static ActivitiesCubit get(BuildContext context) => BlocProvider.of<ActivitiesCubit>(context);


  List<Activity> activities = [];

  Future<void> editActivity(Activity activity) async {
    final failureOrEdit = await editActivityUseCase(activity);
    emit(await mapFailureOrActivitiesToState(failureOrEdit, state: 'edit'));
  }

  Future<void> deleteActivity(
    int id,
  ) async {
    final failureOrDelete = await deleteActivityUseCase(id);
    emit(await mapFailureOrActivitiesToState(failureOrDelete, state: 'delete'));
  }

  Future<void> addActivity(Activity activity) async {
    final failureOrAdd = await addActivityUseCase(activity);
    emit(await mapFailureOrActivitiesToState(failureOrAdd, state: 'add'));
  }

  Future<void> getActivities() async {
    emit(LoadingGetActivitiesState());
    final failureOrGet = await getActivitiesUseCase();
    emit(await mapFailureOrActivitiesToState(failureOrGet, state: 'get'));
  }

  Future<void> searchActivity(String name) async {
    emit(LoadingGetActivitiesState());
    final failureOrSearch = await searchActivityUseCase(name);
    emit(await mapFailureOrActivitiesToState(failureOrSearch, state: 'get'));
  }

  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case EmptyDatabase _:
        return emptyFailure;
      case MealNotFound _:
        return mealNotFound;
      default:
        return "UnexpectedError , please try again later";
    }
  }

  Future<ActivitiesStates> mapFailureOrActivitiesToState(
      Either<Failure, dynamic> either,
      {required String state}) async {
    return either.fold(
      (failure) {
        String stringFailure = mapFailureToMessage(failure);
        switch (state) {
          case 'delete':
            return ErrorDeleteActivityState(error: stringFailure);
          case 'edit':
            return ErrorEditActivityState(error: stringFailure);
          case 'add':
            return ErrorAddActivityState(error: stringFailure);
          default:
            return ErrorGetActivitiesState(error: stringFailure);
        }
      },
      (activities) async {
        switch (state) {
          case 'delete':
            {
              await getActivities();
              return SuccessDeleteActivityState(
                  message: 'delete activity succeed');
            }
          case 'edit':
            {
              await getActivities();
              return SuccessEditActivityState(message: 'edit activity succeed');
            }
          case 'add':
            {
              await getActivities();
              return SuccessAddActivityState(message: 'add activity succeed');
            }
          default:
            this.activities = activities as List<Activity>;
            return SuccessGetActivitiesState(activities: activities);
        }
      },
    );
  }
}
