// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TasksStore on _TasksStore, Store {
  Computed<PendingTaskStoreListState>? _$pendingTasksStateComputed;

  @override
  PendingTaskStoreListState get pendingTasksState =>
      (_$pendingTasksStateComputed ??= Computed<PendingTaskStoreListState>(
              () => super.pendingTasksState,
              name: '_TasksStore.pendingTasksState'))
          .value;
  Computed<CompletedTaskStoreListState>? _$completedTasksStateComputed;

  @override
  CompletedTaskStoreListState get completedTasksState =>
      (_$completedTasksStateComputed ??= Computed<CompletedTaskStoreListState>(
              () => super.completedTasksState,
              name: '_TasksStore.completedTasksState'))
          .value;

  late final _$pendingTaskListAtom =
      Atom(name: '_TasksStore.pendingTaskList', context: context);

  @override
  ObservableList<TaskModel> get pendingTaskList {
    _$pendingTaskListAtom.reportRead();
    return super.pendingTaskList;
  }

  @override
  set pendingTaskList(ObservableList<TaskModel> value) {
    _$pendingTaskListAtom.reportWrite(value, super.pendingTaskList, () {
      super.pendingTaskList = value;
    });
  }

  late final _$completedTaskListAtom =
      Atom(name: '_TasksStore.completedTaskList', context: context);

  @override
  ObservableList<TaskModel> get completedTaskList {
    _$completedTaskListAtom.reportRead();
    return super.completedTaskList;
  }

  @override
  set completedTaskList(ObservableList<TaskModel> value) {
    _$completedTaskListAtom.reportWrite(value, super.completedTaskList, () {
      super.completedTaskList = value;
    });
  }

  late final _$messageAtom =
      Atom(name: '_TasksStore.message', context: context);

  @override
  String get message {
    _$messageAtom.reportRead();
    return super.message;
  }

  bool _messageIsInitialized = false;

  @override
  set message(String value) {
    _$messageAtom
        .reportWrite(value, _messageIsInitialized ? super.message : null, () {
      super.message = value;
      _messageIsInitialized = true;
    });
  }

  late final _$addNewTaskAsyncAction =
      AsyncAction('_TasksStore.addNewTask', context: context);

  @override
  Future addNewTask(
      String listId, String taskName, String taskDescription, String dueDate) {
    return _$addNewTaskAsyncAction.run(
        () => super.addNewTask(listId, taskName, taskDescription, dueDate));
  }

  late final _$getPendingTasksAsyncAction =
      AsyncAction('_TasksStore.getPendingTasks', context: context);

  @override
  Future<List<TaskModel>> getPendingTasks(String listId) {
    return _$getPendingTasksAsyncAction
        .run(() => super.getPendingTasks(listId));
  }

  late final _$getCompletedTasksAsyncAction =
      AsyncAction('_TasksStore.getCompletedTasks', context: context);

  @override
  Future<List<TaskModel>> getCompletedTasks(String listId) {
    return _$getCompletedTasksAsyncAction
        .run(() => super.getCompletedTasks(listId));
  }

  late final _$_TasksStoreActionController =
      ActionController(name: '_TasksStore', context: context);

  @override
  dynamic completeTask(String listId, String taskId) {
    final _$actionInfo = _$_TasksStoreActionController.startAction(
        name: '_TasksStore.completeTask');
    try {
      return super.completeTask(listId, taskId);
    } finally {
      _$_TasksStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pendingTaskList: ${pendingTaskList},
completedTaskList: ${completedTaskList},
message: ${message},
pendingTasksState: ${pendingTasksState},
completedTasksState: ${completedTasksState}
    ''';
  }
}
