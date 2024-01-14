import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_mobx_clean_firebase/data/models/task_model.dart';
import 'package:todo_mobx_clean_firebase/domain/repositories/get_all_tasks_repository.dart';

class GetAllTasksRepoImpl implements GetAllTasksRepository {
  @override
  Future<List<TaskModel>> getPendingTasks(String listId) async {
    List<TaskModel> pendingTaskList = [];
    print("list id in get_all_tasks_repo $listId");
    try {
      QuerySnapshot<Map<String, dynamic>> pendingTaskCollection =
          await FirebaseFirestore.instance
              .collection("lists")
              .doc(listId)
              .collection("tasks")
              .where("completed", isEqualTo: false)
              .get();

      for (QueryDocumentSnapshot documentSnapshot
          in pendingTaskCollection.docs) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        pendingTaskList.add(TaskModel.fromJson(data));
        print("got pending tasks tasks repo");
      }
      print("got tasks repo 2");
    } catch (e) {
      print(
          "error fetching pending tasks pendingTaskCollection in ${listId} + ${e} ");
    }
    for (int i = 0; i < pendingTaskList.length; i++) {
      print("task  id repo ${pendingTaskList[i].taskId}");
      print("task  name repo ${pendingTaskList[i].taskName}");
    }
    return pendingTaskList;
  }

  @override
  Future<List<TaskModel>> getCompletedTasks(String listId) async {
    List<TaskModel> completedTasksList = [];
    try {
      QuerySnapshot<Map<String, dynamic>> completedTasksCollection =
          await FirebaseFirestore.instance
              .collection("lists")
              .doc(listId)
              .collection("tasks")
              .where("completed", isEqualTo: true)
              .get();

      for (QueryDocumentSnapshot documentSnapshot
          in completedTasksCollection.docs) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        completedTasksList.add(TaskModel.fromJson(data));
      }
      completedTasksList.forEach((element) {
        print(" completed task repo - ${element.taskName}");
      });
    } catch (e) {
      print("error getting completed tasks repo - $e");
    }
    return completedTasksList;
  }

  @override
  completeTask(String listId, String taskId) async {
    try {
      await FirebaseFirestore.instance
          .collection("lists")
          .doc(listId)
          .collection("tasks")
          .doc(taskId)
          .update({"completed": true});
    } catch (e) {
      print("error completing task repo $e");
    }
  }
}
