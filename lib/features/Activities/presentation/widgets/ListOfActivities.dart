import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/l10n.dart';
import '../../../../global/global_methods.dart';
import '../../domain/entities/activity.dart';
import '../bloc/ActivitiesBloc/cubit.dart';
import 'ActivityElement.dart';
import 'add acticity to burning sheet.dart';

class ListOfActivities extends StatelessWidget {
  final List<Activity> activities;

  const ListOfActivities({
    super.key,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      itemBuilder: (context, index) {
        final activity = activities[index];
        return Dismissible(
          key: Key(activity.id.toString()),
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
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) {
            context.read<ActivitiesCubit>().deleteActivity(activity.id!);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.of(context).deleted(isArabic() ? activity.titleAr : activity.title))),
            );
          },
          child: GestureDetector(
            onTap: () {
              addActivityToBurningSheet(
                context,
                activity: activity,
              );
            },
            child: ActivityElement(
              activity: activity,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 12,
      ),
      itemCount: activities.length,
    );
  }
}
