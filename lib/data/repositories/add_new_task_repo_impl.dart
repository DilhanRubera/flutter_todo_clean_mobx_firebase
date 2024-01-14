import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_mobx_clean_firebase/data/models/task_model.dart';
import 'package:todo_mobx_clean_firebase/domain/repositories/add_new_task_repository.dart';

class AddNewTaskRepoImpl implements AddNewTaskRepository {
  @override
  Future<TaskModel> addNewTaskToFirestore(String listId, String taskName,
      String taskDescription, String dueDate) async {
    TaskModel newTask = TaskModel(taskName: "", completed: false, taskId: "");

    CollectionReference listCollection =
        FirebaseFirestore.instance.collection("lists");

    try {
      DocumentReference<Map<String, dynamic>> taskDoc =
          listCollection.doc(listId).collection("tasks").doc();
      newTask.taskName = taskName;
      newTask.taskId = taskDoc.id;
      newTask.taskDescription = taskDescription;
      newTask.dueDate = dueDate;
      Map<String, dynamic> newTaskMap = newTask.toJson();
      await taskDoc.set(newTaskMap);
    } catch (e) {
      print("Error adding new task to list repo $e");
    }
    return newTask;
  }
}
