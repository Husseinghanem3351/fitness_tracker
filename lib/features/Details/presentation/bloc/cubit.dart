import 'package:flutter/material.dart';
import 'package:fitness_tracker/features/Details/presentation/bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/l10n.dart';
import '../../../../global/errors/failure.dart';
import '../../../../global/global.dart';
import '../../../../global/global_methods.dart';
import '../../../../global/strings/failures.dart';
import '../../domain/entities/burning.dart';
import '../../domain/entities/dailyCalories.dart';
import '../../domain/entities/eating.dart';
import '../../domain/use_cases/GetDaliyCalories.dart';
import '../../domain/use_cases/UpdateCaloriesUseCase.dart';
import '../../domain/use_cases/addBurningCaloriesUseCase.dart';
import '../../domain/use_cases/addEatngCaloriesUseCase.dart';
import '../../domain/use_cases/deleteBurningUseCase.dart';
import '../../domain/use_cases/deleteEatingCaloriesUseCase.dart';
import '../../domain/use_cases/getBurningCaloriesUseCase.dart';
import '../../domain/use_cases/getEatingCaloriesUseCase.dart';
import '../../../Home/presentation/cubit/cubit.dart';

class DetailsCubit extends Cubit<DetailsStates> {
  final AddBurningCaloriesUseCase addBurningCaloriesUseCase;
  final AddEatingCaloriesUseCase addEatingCaloriesUseCase;
  final DeleteBurningCaloriesUseCase deleteBurningCaloriesUseCase;
  final DeleteEatingCaloriesUseCase deleteEatingCaloriesUseCase;
  final GetBurningCaloriesUseCase getBurningCaloriesUseCase;
  final GetDailyCaloriesUseCase getDailyCaloriesUseCase;
  final GetEatingCaloriesUseCase getEatingCaloriesUseCase;
  final UpdateCaloriesUseCase updateCaloriesUseCase;

  DetailsCubit({
    required this.addBurningCaloriesUseCase,
    required this.addEatingCaloriesUseCase,
    required this.deleteBurningCaloriesUseCase,
    required this.deleteEatingCaloriesUseCase,
    required this.getBurningCaloriesUseCase,
    required this.getDailyCaloriesUseCase,
    required this.getEatingCaloriesUseCase,
    required this.updateCaloriesUseCase,
  }) : super(InitDetailsState());

  static DetailsCubit get(BuildContext context) => BlocProvider.of<DetailsCubit>(context);

  List details = [];
  List showDetails = []; 
  List<DailyCalories> dailyCaloriesList = [];

  Future<void> getDetailsData({BuildContext? context}) async {
    emit(LoadingGetDetailsState());
    final failureOrEatingCalories = await getEatingCaloriesUseCase();
    final failureOrBurningCalories = await getBurningCaloriesUseCase();
    
    failureOrEatingCalories.fold(
      (l) => emit(ErrorGetDetailsState(error: 'get eating error')),
      (eating) {
        failureOrBurningCalories.fold(
          (l) => emit(ErrorGetDetailsState(error: 'get burning error')),
          (burning) {
            details = showDetails = sortTwoList(eating, burning);
            calculateDetailsCalories(context: context);
            emit(SuccessGetDetailsState());
          },
        );
      },
    );
  }

  Future<void> calculateDetailsCalories({BuildContext? context}) async {
    eatingCarb = 0;
    eatingProtein = 0;
    eatingFat = 0;
    eatingCalories = 0;
    burningCalories = 0;

    final now = DateTime.now();
    for (var item in details) {
      final date = item.date;
      if (date != null && 
          date.year == now.year && 
          date.month == now.month && 
          date.day == now.day) {
        if (item is Eating) {
          eatingCarb += item.carb ?? 0;
          eatingProtein += item.protein ?? 0;
          eatingFat += item.fat ?? 0;
          eatingCalories += item.calories ?? 0;
        } else if (item is Burning) {
          burningCalories += item.calories ?? 0;
        }
      }
    }

    eatRemainingCalories = dailyGoalCalories - eatingCalories + burningCalories;

    if (context != null) {
      final homeCubit = HomeCubit.get(context);
      homeCubit.refreshDashboard(burningCalories);
    }
    emit(CalculateDetailsCaloriesSuccess());
  }

  Future<void> getDailyCaloriesData() async {
    emit(LoadingGetDailyCaloriesState());
    getDailyCaloriesUseCase().then((value) {
      value.fold((failure) {
        emit(ErrorGetDailyCaloriesState(error: mapFailureToMessage(failure)));
      }, (data) {
        dailyCaloriesList = data;
        emit(SuccessGetDailyCaloriesState());
      });
    });
  }

  Future<void> addToEatingCalories(Eating eatingElement, BuildContext context) async {
    final addOrFailure = await addEatingCaloriesUseCase(eatingElement);
    addOrFailure.fold(
      (failure) => emit(ErrorAddDetailsState(error: mapFailureToMessage(failure))),
      (unit) async {
        await getDetailsData(context: context);
        await updateCaloriesUseCase();
        if (context.mounted) {
          HomeCubit.get(context).updatePetMood(
            customMessage: isArabic() ? "يا لها من وجبة شهية! 😋" : "What a delicious meal! 😋",
          );
          emit(SuccessAddDetailsState(message: S.of(context).addedSuccess));
        }
      },
    );
  }

  Future<void> addToBurningCalories(Burning burningElement, BuildContext context) async {
    final addOrFailure = await addBurningCaloriesUseCase(burningElement);
    addOrFailure.fold(
      (failure) => emit(ErrorAddDetailsState(error: mapFailureToMessage(failure))),
      (unit) async {
        await getDetailsData(context: context);
        await updateCaloriesUseCase();
        if (context.mounted) {
          HomeCubit.get(context).updatePetMood(
            customMessage: isArabic() ? "أنت وحش! استمر في التقدم! 🔥" : "You're a beast! Keep going! 🔥",
          );
          emit(SuccessAddDetailsState(message: S.of(context).addedSuccess));
        }
      },
    );
  }

  Future<void> deleteBurningCalories(int id, BuildContext context) async {
    final deleteOrFailure = await deleteBurningCaloriesUseCase(id);
    deleteOrFailure.fold(
      (failure) => emit(ErrorDeleteDetailsState(error: mapFailureToMessage(failure))),
      (unit) async {
        await getDetailsData(context: context);
        await updateCaloriesUseCase();
        if (context.mounted) {
          emit(SuccessDeleteDetailsState(message: S.of(context).deleteSucceed));
        }
      },
    );
  }

  Future<void> deleteEatingCalories(int id, BuildContext context) async {
    final deleteOrFailure = await deleteEatingCaloriesUseCase(id);
    deleteOrFailure.fold(
      (failure) => emit(ErrorDeleteDetailsState(error: mapFailureToMessage(failure))),
      (unit) async {
        await getDetailsData(context: context);
        await updateCaloriesUseCase();
        if (context.mounted) {
          emit(SuccessDeleteDetailsState(message: S.of(context).deleteSucceed));
        }
      },
    );
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

  List sortTwoList(List<Eating> eatingCalories, List<Burning> burningCalories) {
    List details = [...eatingCalories, ...burningCalories];
    details.sort((a, b) {
      DateTime dateA = a.date ?? DateTime.now();
      DateTime dateB = b.date ?? DateTime.now();
      return dateB.compareTo(dateA);
    });
    return details;
  }

  void detailsForDayOrWeek(bool isDay) {
    if (isDay) {
      details = showDetails.where((e) => 
        e.date != null && DateTime.now().difference(e.date!).inHours < 24
      ).toList();
    } else {
      details = showDetails;
    }
    emit(SwapShowDetailsDuration());
  }
}
