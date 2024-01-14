//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_mobx_clean_firebase/presentation/stores/tasks_store.dart';

class TaskInputDialogWidget extends StatefulWidget {
  final String listId;
  const TaskInputDialogWidget({super.key, required this.listId});

  @override
  State<TaskInputDialogWidget> createState() => _TaskInputDialogWidgetState();
}

class _TaskInputDialogWidgetState extends State<TaskInputDialogWidget> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  late TextEditingController inputTaskController = TextEditingController();
  late TextEditingController inputTaskDescriptonController =
      TextEditingController();
  late TextEditingController datePickerController = TextEditingController();
  late TasksStore _tasksStore;

  @override
  Widget build(BuildContext context) {
    _tasksStore = Provider.of<TasksStore>(context);
    return AlertDialog(
      title: Text(
        "Input task",
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 15),
      ),
      content: Container(
        height: 175,
        width: 400,
        child: Column(
          children: [
            TextFormField(
              controller: inputTaskController,
              decoration: InputDecoration(
                  hintText: " Task ",
                  hintStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
            ),
            TextFormField(
              controller: inputTaskDescriptonController,
              decoration: InputDecoration(
                  hintText: "Task Description",
                  hintStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
            ),
            SizedBox(height: 10),
            TextField(
              onTap: () {
                openDatePicker(context);
              },
              decoration: InputDecoration(
                  icon: Icon(Icons.calendar_month),
                  label: Text(
                    " Due Date",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  filled: true),
              readOnly: true,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              _tasksStore.addNewTask(
                  widget.listId,
                  inputTaskController.text,
                  inputTaskDescriptonController.text,
                  datePickerController.text);
              Navigator.pop(context);
            },
            child: Text("Add"))
      ],
    );
  }

  Future openDatePicker(context) async {
    DateTime? _dueDate = await showDatePicker(
        context: context, firstDate: DateTime.now(), lastDate: DateTime(2100));
    datePickerController.text = _dueDate.toString().split(" ")[0];
    print(datePickerController.text);
  }
}
