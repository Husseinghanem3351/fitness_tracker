import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/l10n.dart';
import '../../../../global/global_methods.dart';
import '../bloc/cubit.dart';
import '../bloc/states.dart';
import '../widgets/DetailsListItem.dart';
import 'statistics.dart';
import '../../../../features/Home/presentation/cubit/cubit.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = HomeCubit.get(context).isDark;
    Color primaryColor = Colors.indigo;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121416) : Colors.white,
      appBar: AppBar(
        title: Text(
          S.of(context).history,
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              DetailsCubit.get(context).getDailyCaloriesData();
              navigateTo(context, const StatisticsScreen());
            },
            icon: const Icon(Icons.analytics_outlined, color: Colors.indigo),
            label: Text(
              S.of(context).statistics, 
              style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)
            ),
          ),
        ],
      ),
      body: BlocBuilder<DetailsCubit, DetailsStates>(
        builder: (context, state) {
          final cubit = DetailsCubit.get(context);

          if (state is LoadingGetDetailsState) {
            return Center(child: CircularProgressIndicator(color: primaryColor));
          }

          if (cubit.details.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history_rounded, size: 64, color: primaryColor.withValues(alpha: 0.3)),
                  const SizedBox(height: 16),
                  Text(
                    S.of(context).noHistory,
                    style: TextStyle(color: primaryColor.withOpacity(0.6), fontSize: 16),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                confirmDismiss: (direction) async {
                  return await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(S.of(context).confirm),
                      content: Text(S.of(context).deleteConfirm),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(S.of(context).cancel),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text(S.of(context).confirm),
                        ),
                      ],
                    ),
                  );
                },
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.delete_outline, color: Colors.white),
                ),
                onDismissed: (_) {
                  final item = cubit.details[index];
                  if (item.runtimeType.toString().contains('Eating')) {
                    cubit.deleteEatingCalories(item.id!, context);
                  } else {
                    cubit.deleteBurningCalories(item.id!, context);
                  }
                },
                child: DetailsItem(
                  height: 100,
                  detailItems: cubit.details[index],
                ),
              );
            },
            itemCount: cubit.details.length,
          );
        },
      ),
    );
  }
}
