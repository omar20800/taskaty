import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:taskaty/core/extentions/extenstions.dart';
import 'package:taskaty/core/model/task_model.dart';
import 'package:taskaty/core/services/local_helper.dart';
import 'package:taskaty/feature/create%20task/page/addtaskscreen.dart';
import 'package:taskaty/feature/home/widgets/task_card.dart';

class TaskListBuilder extends StatelessWidget {
  const TaskListBuilder({super.key, required this.filterDate, required this.onTap});
  final String? filterDate;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: AppLocalStorage.taskBox!.listenable(),
        builder: (context, box, child)  {
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
                      box.delete(tasks[index].id);
                    },
                    dissLtR: () {
                      box.put(
                        tasks[index].id,
                        tasks[index].copyWith(
                          isCompleted: !tasks[index].isCompleted,
                        ),
                      );
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
