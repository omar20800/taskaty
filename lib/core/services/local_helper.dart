// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:hive/hive.dart';
import 'package:taskaty/core/functions/dateconvert.dart';
import 'package:taskaty/core/model/task_model.dart';

class AppLocalStorage {
  static Box? userBox;
  static Box<TaskModel>? taskBox;

  static String nameKey = "name";
  static String imageKey = "image";
  static String isUploaded = "isUploaded";
  static String isDarkTheme = "isDarkTheme";

  static init() {
    userBox = Hive.box("userBox");
    taskBox = Hive.box<TaskModel>("taskBox");
  }

  static cacheData(String key, dynamic value) async {
    await userBox?.put(key, value);
  }

  static getCachedData(String key) {
    return userBox?.get(key);
  }

  static cacheTask(String key, TaskModel value) async {
    await taskBox?.put(key, value);
  }

  static TaskModel? getCachedTask(String key) {
    return taskBox?.get(key);
  }

  static deleteOldTasks() {
    List<TaskModel>.from(taskBox!.values).forEach((element) async {
      if (dateConvert(element.date).isBefore(DateTime.now())) {
        await taskBox?.delete(element.id);
      }
    });
  }
}
