import 'package:flutter/foundation.dart';
import 'package:todo_mobx_clean_firebase/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required String taskName,
    String? taskId,
    String? taskDescription,
    required bool completed,
    String? dueDate,
  }) : super(
            taskName: taskName,
            completed: completed,
            taskDescription: taskDescription,
            taskId: taskId,
            dueDate: dueDate);

  @override
  Map<String, dynamic> toJson() {
    return ({
      'taskName': taskName,
      'taskId': taskId,
      'taskDescription': taskDescription,
      'completed': completed,
      'dueDate': dueDate,
    });
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
        taskId: json['taskId'],
        taskName: json['taskName'],
        taskDescription: json['taskDescription'],
        completed: json["completed"],
        dueDate: json["dueDate"]);
  }
}
