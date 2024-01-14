abstract class GetAllTasksRepository {
  getPendingTasks(String listId) {}
  getCompletedTasks(String listId) {}
  completeTask(String listId, String taskId) {}
}
