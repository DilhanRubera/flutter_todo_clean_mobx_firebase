import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_mobx_clean_firebase/data/repositories/add_new_listname_repo_impl.dart';
import 'package:todo_mobx_clean_firebase/presentation/stores/listnames_store.dart';

class ListNameInputDialog extends StatefulWidget {
  const ListNameInputDialog({super.key});

  @override
  State<ListNameInputDialog> createState() => _ListNameInputDialogState();
}

class _ListNameInputDialogState extends State<ListNameInputDialog> {
  TextEditingController listNameController = TextEditingController();
  late ListNamesStore _store;

  @override
  Widget build(BuildContext context) {
    // ListNamesStore store = ListNamesStore();
    _store = Provider.of<ListNamesStore>(context);
    return AlertDialog(
      title: const Text("Input list name"),
      content: TextFormField(
        controller: listNameController,
        decoration: const InputDecoration(hintText: "Enter new list name"),
      ),
      actions: [
        TextButton(
            onPressed: () {
              print(listNameController.text);
              _store.addNewList(listNameController.text);
              //AddNewListRepositoryImpl().addNewList(listNameController.text);
              Navigator.of(context).pop();
            },
            child: const Text('Ok'))
      ],
    );
  }
}
