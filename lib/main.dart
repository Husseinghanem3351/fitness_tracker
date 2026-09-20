import 'package:fitness_tracker/bloc_observer.dart';
import 'package:fitness_tracker/features/Activities/presentation/bloc/ActivitiesBloc/cubit.dart';
import 'package:fitness_tracker/features/Details/presentation/bloc/cubit.dart';
import 'package:fitness_tracker/features/Home/presentation/cubit/cubit.dart';
import 'package:fitness_tracker/features/Home/presentation/cubit/states.dart';
import 'package:fitness_tracker/features/Home/presentation/screens/home.dart';
import 'package:fitness_tracker/features/Home/presentation/screens/info_screen.dart';
import 'package:fitness_tracker/features/Home/presentation/screens/language_screen.dart';
import 'package:fitness_tracker/features/Home/presentation/screens/onboarding.dart';
import 'package:fitness_tracker/features/Meals/presentation/bloc/MealsCubit/MealsCubit.dart';
import 'package:fitness_tracker/global/global_methods.dart';
import 'package:fitness_tracker/global/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'features/Home/data/cache helper.dart';
import 'generated/l10n.dart';
import 'global/global.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await createDatabase();
  await CacheHelper.init();
  deleteOldDate();
  
  // Load language preference
  String? savedLang = CacheHelper.getData(key: 'language');
  if (savedLang != null && savedLang.isNotEmpty) {
    language = savedLang;
  }
  
  // Load other preferences
  bool onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;
  bool isGettingInfo = CacheHelper.getData(key: 'personalInfo') != null;
  final bool? isDark = CacheHelper.getData(key: 'isDark');
  
  Bloc.observer = MyBlocObserver();
  runApp(
    MyApp(
      hasLang: (savedLang != null && savedLang.isNotEmpty),
      onBoarding: onBoarding,
      isPersonalInfo: isGettingInfo,
      isDark: isDark,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.hasLang, required this.onBoarding, required this.isPersonalInfo, required this.isDark});

  final bool hasLang;
  final bool onBoarding;
  final bool isPersonalInfo;
  final bool? isDark;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<HomeCubit>()
            ..changeDarkMode(fromShared: isDark)
            ..calculateMain(),
        ),
        BlocProvider(
          create: (context) => di.sl<MealsCubit>()..getMeals(),
        ),
        BlocProvider(
          create: (context) => di.sl<ActivitiesCubit>()..getActivities(),
        ),
        BlocProvider(
          create: (context) => di.sl<DetailsCubit>()..getDetailsData(),
        ),
      ],
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          themeMode:
              HomeCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          darkTheme: darkTheme,
          theme: lightTheme,
          locale: Locale(language),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          title: 'Zelora',
          home: !hasLang 
              ? const LanguageScreen()
              : (onBoarding 
                  ? (!isPersonalInfo ? const InfoScreen() : const Home()) 
                  : const OnBoardingScreen()),
        ),
      ),
    );
  }
}
