import 'package:todo_mobx_clean_firebase/data/models/task_model.dart';
import 'package:todo_mobx_clean_firebase/domain/entities/list_entity.dart';

class ListModel extends ListEntity {
  ListModel({
    String? listId,
    required String listName,
    int? noOfTasks,
    List<TaskModel>? taskList,
  }) : super(
          listName: listName,
          taskList: taskList,
          listId: listId,
          noOfTasks: noOfTasks,
        );

  @override
  Map<String, dynamic> toJson() {
    return {
      'listId': listId,
      'listName': listName,
      'noOfTasks': noOfTasks,
      'taskList': taskList
          ?.map((task) => task.toJson())
          .toList(), // Assuming TaskModel has a toMap method
    };
  }

  @override
  factory ListModel.fromJson(Map<String, dynamic> json) {
    return ListModel(
        listId: json['listId'],
        listName: json['listName'],
        noOfTasks: json['noOfTasks'],
        taskList: (json['taskList'] as List<dynamic>?)
            ?.map((taskJson) => TaskModel.fromJson(taskJson))
            .toList());
  }
}
