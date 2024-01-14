// ignore_for_file: public_member_api_docs, sort_constructors_first
class TaskEntity {
  String taskName;
  String? taskId;
  String? taskDescription;
  bool completed;
  String? dueDate;
  TaskEntity({
    required this.taskName,
    this.taskId,
    this.taskDescription,
    required this.completed,
    this.dueDate,
  });

  toJson() {}
  fromJson() {}
}
