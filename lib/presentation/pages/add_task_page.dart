// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_mobx_clean_firebase/core/routes.dart';

import 'package:todo_mobx_clean_firebase/data/models/list_model.dart';
import 'package:todo_mobx_clean_firebase/data/models/task_model.dart';
import 'package:todo_mobx_clean_firebase/presentation/stores/tasks_store.dart';
import 'package:todo_mobx_clean_firebase/presentation/widgets/task_input_dialog_widget.dart';

class AddTaskPage extends StatefulWidget {
  final ListModel listModel;

  const AddTaskPage({
    Key? key,
    required this.listModel,
  }) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  late TasksStore _tasksStore;
  late List<ReactionDisposer> _disposers;
  bool? check = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tasksStore = Provider.of<TasksStore>(context);
    _tasksStore.getPendingTasks(widget.listModel.listId!);
    _tasksStore.getCompletedTasks(widget.listModel.listId!);
    _disposers = [
      reaction((_) => _tasksStore.message, (String message) {
        if (!(message == '')) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));
        }
      }),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    for (var disposer in _disposers) {
      disposer();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("ADD TASK PAGE${widget.listModel.listId}");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tasks",
          style: TextStyle(color: Colors.grey),
        ),
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            GoRouter.of(context).go(AppRouter.homePath);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.grey,
        foregroundColor: Colors.black,
        onPressed: () {
          // String taskName = "hi";
          // _tasksStore.addNewTask(widget.listModel.listId!, taskName);
          showTaskInputDialog(context, widget.listModel.listId!);
        },
        label: const Text("New Task"),
        icon: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Observer(
                builder: (_) {
                  if (_tasksStore.pendingTasksState ==
                      PendingTaskStoreListState.haveTasks) {
                    return SizedBox(
                      width: 300,
                      height: 300,
                      child: Column(
                        children: [
                          const SizedBox(
                            width: 300,
                            height: 35,
                            child: Text(
                              "Pending Tasks",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 300,
                            height: 200,
                            child: ListView.builder(
                              itemCount: _tasksStore.pendingTaskList.length,
                              itemBuilder: ((context, index) {
                                TaskModel task =
                                    _tasksStore.pendingTaskList[index];

                                return Observer(
                                  builder: (_) => ListTile(
                                    title: Text(
                                      task.taskName,
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    subtitle: Text(
                                        task.taskDescription ??
                                            "No description",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                    leading: Checkbox(
                                      onChanged: (val) {
                                        task.completed = val!;
                                        // _tasksStore.pendingTaskList[index]
                                        //     .completed = val!;
                                        _tasksStore.completeTask(
                                            widget.listModel.listId!,
                                            task.taskId!);
                                        print("check boz value $val");
                                      },
                                      value: task.completed,
                                      tristate: true,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        Container(
                          width: 300,
                          height: 35,
                          child: const Text(
                            "No pending Tasks",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 270,
                        )
                      ],
                    );
                  }
                },
              ),
              const Divider(
                height: 0.5,
                indent: 50,
                endIndent: 50,
              ),
              const SizedBox(
                height: 20,
              ),
              Observer(builder: (_) {
                if (_tasksStore.completedTasksState ==
                    CompletedTaskStoreListState.haveTasks) {
                  return Column(
                    children: [
                      const SizedBox(
                        width: 300,
                        height: 35,
                        child: Text(
                          "Completed Tasks",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        height: 220,
                        child: ListView.builder(
                            itemCount: _tasksStore.completedTaskList.length,
                            itemBuilder: ((context, index) {
                              TaskModel completedTask =
                                  _tasksStore.completedTaskList[index];
                              return ListTile(
                                title: Text(
                                  completedTask.taskName,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                subtitle: Text(
                                  completedTask.taskDescription ??
                                      "No description",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                leading: Checkbox(
                                  activeColor: Colors.grey,
                                  value: true,
                                  onChanged: (bool? value) {},
                                ),
                              );
                            })),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Container(
                        width: 300,
                        height: 30,
                        child: const Text(
                          "No Completed Tasks",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 150,
                      )
                    ],
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> showTaskInputDialog(context, String listId) {
  return showDialog(
      context: context,
      builder: (context) => TaskInputDialogWidget(listId: listId));
}
