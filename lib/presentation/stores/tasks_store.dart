//import 'dart:js_interop';

import 'package:mobx/mobx.dart';
import 'package:todo_mobx_clean_firebase/data/models/task_model.dart';
import 'package:todo_mobx_clean_firebase/data/repositories/add_new_task_repo_impl.dart';
import 'package:todo_mobx_clean_firebase/data/repositories/get_all_tasks_repo_impl.dart';

part 'tasks_store.g.dart';

enum PendingTaskStoreListState { haveTasks, noTasks }

enum CompletedTaskStoreListState { haveTasks, noTasks }

class TasksStore extends _TasksStore with _$TasksStore {}

abstract class _TasksStore with Store {
  @observable
  ObservableList<TaskModel> pendingTaskList = ObservableList<TaskModel>();

  @observable
  ObservableList<TaskModel> completedTaskList = ObservableList<TaskModel>();

  @observable
  late String message;

  @computed
  PendingTaskStoreListState get pendingTasksState {
    if (pendingTaskList.isEmpty) {
      return PendingTaskStoreListState.noTasks;
    } else {
      return PendingTaskStoreListState.haveTasks;
    }
  }

  @computed
  CompletedTaskStoreListState get completedTasksState {
    if (completedTaskList.isEmpty) {
      return CompletedTaskStoreListState.noTasks;
    } else {
      return CompletedTaskStoreListState.haveTasks;
    }
  }

  @action
  addNewTask(String listId, String taskName, String taskDescription,
      String dueDate) async {
    try {
      message = "";
      TaskModel newTask = await AddNewTaskRepoImpl()
          .addNewTaskToFirestore(listId, taskName, taskDescription, dueDate);
      pendingTaskList.add(newTask);
      message = "Task added successfully";
    } catch (e) {
      message = "Error adding new task - $e ";
    }
  }

  @action
  Future<List<TaskModel>> getPendingTasks(String listId) async {
    try {
      pendingTaskList = ObservableList<TaskModel>.of(
          await GetAllTasksRepoImpl().getPendingTasks(listId));
      print("got tasks store");
    } catch (e) {
      print("error getting pending tasks");
    }
    for (int i = 0; i < pendingTaskList.length; i++) {
      print("store task list id${pendingTaskList[i].taskId}");
      print("store task list name${pendingTaskList[i].taskName}");
    }
    return pendingTaskList;
  }

  @action
  Future<List<TaskModel>> getCompletedTasks(String listId) async {
    try {
      completedTaskList = ObservableList<TaskModel>.of(
          await GetAllTasksRepoImpl().getCompletedTasks(listId));
    } catch (e) {
      print("eror getting Completed tasks store $e ");
    }
    completedTaskList.forEach((element) {
      print(" completed task store - ${element.taskName}");
    });
    return completedTaskList;
  }

  @action
  completeTask(String listId, String taskId) {
    try {
      GetAllTasksRepoImpl().completeTask(listId, taskId);
      TaskModel newCompletedTask = pendingTaskList
          .firstWhere((pendingTask) => pendingTask.taskId == taskId);
      pendingTaskList
          .removeWhere((pendingTask) => pendingTask.taskId == taskId);
      completedTaskList.add(newCompletedTask);
    } catch (e) {
      print("error completing task $e");
    }
  }
}
