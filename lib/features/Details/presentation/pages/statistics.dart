import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/l10n.dart';
import '../bloc/cubit.dart';
import '../bloc/states.dart';
import '../widgets/statisticsListItem.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color appBarColor = isDark ? const Color(0xFF0B0E11) : Colors.white;

    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: isDark ? const Color(0xFF0B0E11) : Colors.white,
      appBar: AppBar(
        title: Text(
          S.of(context).statistics, 
          style: TextStyle(color: isDark ? Colors.white : Colors.indigo, fontWeight: FontWeight.bold)
        ),
        backgroundColor: appBarColor,
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.indigo),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<DetailsCubit, DetailsStates>(
        builder: (context, state) {
          final cubit = DetailsCubit.get(context);
          
          if (state is LoadingGetDailyCaloriesState) {
            return Center(child: CircularProgressIndicator(color: isDark ? Colors.indigoAccent[100] : Colors.indigo));
          }

          if (cubit.dailyCaloriesList.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.bar_chart_rounded, size: 64, color: isDark ? Colors.white24 : Colors.indigo.withValues(alpha: 0.2)),
                    const SizedBox(height: 16),
                    Text(
                      S.of(context).noDailyHistory,
                      style: TextStyle(color: isDark ? Colors.white38 : Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return StatisticsListItem(
                dailyCalories: cubit.dailyCaloriesList[index],
              );
            },
            itemCount: cubit.dailyCaloriesList.length,
          );
        },
      ),
    );
  }
}
