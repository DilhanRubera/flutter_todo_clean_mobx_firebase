// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:todo_mobx_clean_firebase/domain/entities/task_entity.dart';

class ListEntity {
  String? listId;
  String listName;
  int? noOfTasks;
  List<TaskEntity>? taskList;

  ListEntity(
      {this.listId, required this.listName, this.noOfTasks, this.taskList});
  toJson() {}

  fromJson() {}
}
