import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:taskaty/core/functions/dateconvert.dart';
import 'package:taskaty/core/functions/get_color.dart';
import 'package:taskaty/core/functions/timeconvert.dart';
import 'package:taskaty/core/model/task_model.dart';
import 'package:taskaty/core/services/local_helper.dart';
import 'package:taskaty/core/services/notify_service.dart';
import 'package:taskaty/feature/home/widgets/task_card.dart';

class TaskListBuilder extends StatelessWidget {
  const TaskListBuilder({
    super.key,
    required this.filterDate,
    required this.onTap,
  });
  final String? filterDate;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: AppLocalStorage.taskBox!.listenable(),
        builder: (context, box, child) {
          List<TaskModel> tasks =
              box.values
                  .where((element) => element.date == filterDate)
                  .toList();
          if (tasks.isEmpty) {
            return Center(
              child: Lottie.asset('assets/images/empty.json', width: 500),
            );
          } else {
            return ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    onTap(tasks[index]);
                  },
                  child: TaskCard(
                    title: tasks[index].title,
                    description: tasks[index].description,
                    date: tasks[index].date,
                    startime: tasks[index].starttime,
                    endtime: tasks[index].endtime,
                    color: tasks[index].color,
                    isCompleted: tasks[index].isCompleted,
                    dissRtL: () {
                      NotifyService().cancel(int.parse(tasks[index].id));
                      NotifyService().cancel(int.parse(tasks[index].id) + 1);
                      box.delete(tasks[index].id);
                    },
                    dissLtR: () async {
                      if (tasks[index].isCompleted == false) {
                        await NotifyService().cancel(
                          int.parse(tasks[index].id),
                        );
                        box.put(
                          tasks[index].id,
                          tasks[index].copyWith(isCompleted: true),
                        );
                      } else {
                        await NotifyService().scheduleNotification(
                          id: int.parse(tasks[index].id),
                          title: tasks[index].title,
                          color: getColor(tasks[index].color),
                          body: 'you have a task starts in one hour',
                          year: dateConvert(tasks[index].date).year,
                          month: dateConvert(tasks[index].date).month,
                          day: dateConvert(tasks[index].date).day,
                          hour: timeConvert(tasks[index].starttime).hour - 1,
                          minute: timeConvert(tasks[index].starttime).minute,
                        );
                        await NotifyService().scheduleNotification(
                          id: int.parse(tasks[index].id),
                          title: tasks[index].title,
                          color: getColor(tasks[index].color),
                          body: 'you have a task starts in one hour',
                          year: dateConvert(tasks[index].date).year,
                          month: dateConvert(tasks[index].date).month,
                          day: dateConvert(tasks[index].date).day,
                          hour: timeConvert(tasks[index].starttime).hour - 1,
                          minute: timeConvert(tasks[index].starttime).minute,
                        );
                        box.put(
                          tasks[index].id,
                          tasks[index].copyWith(isCompleted: false),
                        );
                      }
                    },
                  ),
                );
              },
              itemCount: tasks.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
            );
          }
        },
      ),
    );
  }
}
