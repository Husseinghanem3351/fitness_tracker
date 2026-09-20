import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/l10n.dart';
import '../../../../global/global_methods.dart';
import '../../../../global/global.dart';
import '../../../Details/presentation/bloc/cubit.dart';
import '../../../Details/presentation/bloc/states.dart';
import '../../../Details/presentation/pages/details.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../widgets/details_widget.dart';
import '../widgets/fitness_pet_widget.dart';
import '../widgets/floating_action_button.dart';
import '../widgets/gradiant.dart';
import '../widgets/water_tracker.dart';
import 'info_screen.dart';
import 'meal_plan_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        bool isDark = cubit.isDark;
        bool showAddButton = cubit.showAddButton;
        Color scaffoldBg = isDark ? const Color(0xFF0B0E11) : Colors.blueGrey[50]!;
        Color appBarColor = isDark ? const Color(0xFF0B0E11) : Colors.white;

        if (state is CalculateBmrLoading) {
          return Scaffold(
            backgroundColor: scaffoldBg,
            body: const Center(child: CircularProgressIndicator(color: Colors.indigo)),
          );
        }

        return Scaffold(
          backgroundColor: scaffoldBg,
          appBar: AppBar(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  S.of(context).appName,
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.indigo[900],
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.indigoAccent[100]!.withValues(alpha: 0.1) : Colors.indigo.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.fitness_center_rounded,
                    color: isDark ? Colors.indigoAccent[100] : Colors.indigo,
                    size: 20,
                  ),
                ),
              ],
            ),
            centerTitle: true,
            backgroundColor: appBarColor,
            elevation: 2,
            iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.indigo[900]),
            actions: [
              IconButton(
                onPressed: () => navigateTo(context, const Details()),
                icon: const Icon(Icons.history_rounded),
                tooltip: S.of(context).statistics,
                color: isDark ? Colors.white70 : Colors.indigo[900],
              ),
            ],
          ),
          floatingActionButton: FloatingButton(
            showAddButton: showAddButton,
          ),
          body: Stack(
            children: [
              MainBody(isDark: isDark),
              if (showAddButton) const GradiantWidget(),
            ],
          ),
          drawer: drawerWidget(context, width: width),
        );
      },
    );
  }

  Widget drawerWidget(BuildContext context, {required double width}) {
    var cubit = HomeCubit.get(context);
    bool isDark = cubit.isDark;

    return Drawer(
      backgroundColor: isDark ? Colors.grey[900] : Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.indigo,
            ),
            child: Center(
              child: Text(
                personalInfo?.name ?? S.of(context).user,
                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_outline_rounded, color: Colors.indigo),
            title: Text(S.of(context).personalInfo),
            onTap: () {
              Navigator.pop(context);
              navigateTo(context, const InfoScreen());
            },
          ),
          ListTile(
            leading: Icon(isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded, color: Colors.indigo),
            title: Text(isDark
                ? S.of(context).lightMode
                : S.of(context).darkMode),
            onTap: () {
              Navigator.pop(context);
              cubit.changeDarkMode();
            },
          ),
          ListTile(
            leading: const Icon(Icons.restaurant_menu_rounded, color: Colors.indigo),
            title: Text(S.of(context).weeklyMealPlan),
            onTap: () {
              Navigator.pop(context);
              navigateTo(context, const MealPlanScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.translate_rounded, color: Colors.indigo),
            title: Text(S.of(context).changeLanguage),
            onTap: () {
               Navigator.pop(context);
               cubit.changeLanguage();
            },
          ),
        ],
      ),
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).details,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.indigo[900],
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 16),
            const FitnessPetWidget(),
            const SizedBox(height: 16),
            _buildMealPlanShortcut(context),
            const SizedBox(height: 16),
            BlocBuilder<HomeCubit, HomeStates>(
              builder: (context, homeState) => BlocBuilder<DetailsCubit, DetailsStates>(
                builder: (context, detailsState) => const DetailsWidget(height: 400),
              ),
            ),
            const SizedBox(height: 24),
            BlocBuilder<HomeCubit, HomeStates>(
              builder: (context, state) => WaterTracker(
                height: 200,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildMealPlanShortcut(BuildContext context) {
    bool isDark = HomeCubit.get(context).isDark;
    return GestureDetector(
      onTap: () => navigateTo(context, const MealPlanScreen()),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark 
              ? [Colors.indigo[900]!, Colors.indigo[800]!] 
              : [Colors.indigo[800]!, Colors.indigo[600]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.indigo.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).smartNutritionGuide,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17, letterSpacing: 0.5),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    S.of(context).tailoredMealPlan,
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: Colors.white.withValues(alpha: 0.7), size: 16),
          ],
        ),
      ),
    );
  }
}
