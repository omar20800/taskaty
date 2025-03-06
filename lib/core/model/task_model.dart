import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String date;
  @HiveField(3)
  final String starttime;
  @HiveField(4)
  final String endtime;
  @HiveField(5)
  final bool isCompleted;
  @HiveField(6)
  final int color;
  @HiveField(7)
  final String id;

  TaskModel({
    required this.title,
    required this.description,
    required this.date,
    required this.starttime,
    required this.endtime,
    required this.color,
    required this.id,
    required this.isCompleted,
  });
  TaskModel copyWith({
    String? title,
    String? description,
    String? date,
    String? starttime,
    String? endtime,
    bool? isCompleted,
    int? color,
    String? id,
  }) {
    return TaskModel(
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      starttime: starttime ?? this.starttime,
      endtime: endtime ?? this.endtime,
      isCompleted: isCompleted ?? this.isCompleted,
      color: color ?? this.color,
      id: id ?? this.id,
    );
  }
}
