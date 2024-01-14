import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_mobx_clean_firebase/core/routes.dart';
import 'package:todo_mobx_clean_firebase/data/models/list_model.dart';
import 'package:todo_mobx_clean_firebase/presentation/stores/listnames_store.dart';
import 'package:todo_mobx_clean_firebase/presentation/widgets/list_name_input_dialog_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ListNamesStore _store;
  late List<ReactionDisposer> _disposers;
  // final GlobalKey<ScaffoldState> _scaffolKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<ListNamesStore>(context);
    _store.getAllListsNames();
    _disposers = [
      reaction((_) => _store.message, (String message) {
        // final scaffoldState = _scaffolKey.currentState;
        if (!(message == '')) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));
        }
        //scaffoldState?.showSnackBar(SnackBar(content: Text(message)));
        // _scaffolKey.currentState!
        //     .showSnackBar(SnackBar(content: Text(message)));
      })
    ];
  }

  @override
  void dispose() {
    for (var element in _disposers) {
      element();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _store = Provider.of<ListNamesStore>(context);
    //store.getAllListsNames();
    return Scaffold(
        // key: _scaffolKey,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            //AddNewListRepositoryImpl().addNewList();
            showListNameInputDialog(context);
            // store.getAllListsNames();
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Task'),
        ),
        body: Center(
          child: Observer(
            builder: (_) {
              if (_store.state == ListNamesStoreState.haveLists) {
                return ListView.builder(
                  itemCount: _store.newList.length,
                  itemBuilder: (context, index) {
                    ListModel listModel = _store.newList[index];
                    print("home page doc id ${listModel.listId}");
                    return Column(
                      // onTap: () {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => AddTaskPage(
                      //           listModel: listModel,
                      //         ),
                      //       ));
                      // },

                      children: [
                        Card(
                          elevation: 2,
                          shadowColor: Colors.grey,
                          child: InkWell(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => AddTaskPage(
                              //         listModel: listModel,
                              //       ),
                              //     ));
                              GoRouter.of(context)
                                  .go(AppRouter.addTaskPath, extra: listModel);
                            },
                            child: Container(
                              height: 50,
                              width: 200,
                              child: ListTile(
                                title: Text(
                                  listModel.listName,
                                  style: const TextStyle(fontSize: 17),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    );
                  },
                );
              } else {
                return const Column(
                  children: [Text('initial')],
                );
              }
            },
          ),
        ));
  }
}

Future<void> showListNameInputDialog(BuildContext context) async {
  return showDialog(
      context: context, builder: (context) => const ListNameInputDialog());
}
