import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_mobx_clean_firebase/data/models/list_model.dart';
import 'package:todo_mobx_clean_firebase/domain/repositories/add_new_listname_repository.dart';

class AddNewListRepositoryImpl implements AddNewListRepository {
  @override
  Future<ListModel> addNewList(String name) async {
    ListModel newList = ListModel(listId: '', listName: '');
    try {
      final CollectionReference listCollection =
          FirebaseFirestore.instance.collection('lists');
      //String name = 'Hi';

      //Map<String, dynamic> newListMap = newList.toJson();

      // await listCollection.add(newListMap);
      final doc = listCollection.doc();
      String docId = doc.id;
      print(docId);
      print(name);

      //ListModel newList = ListModel(listName: name, listId: docId);
      newList.listId = docId;
      newList.listName = name;
      newList.noOfTasks = 0;
      Map<String, dynamic> newListMap = newList.toJson();
      print("new listMAP Doc id ${newListMap["listId"]}");

      await doc.set(newListMap);
      print("added a new list name repo");
      //return newList;
    } catch (e) {
      print("Error adding a new list name  repo $e");
    }
    print("new list Doc id ${newList.listId}");

    return newList;
  }

  @override
  Future<int> getListNameCount() async {
    QuerySnapshot<Map<String, dynamic>> listCollection =
        await FirebaseFirestore.instance.collection('lists').get();
    int listNameCount = listCollection.docs.length;
    print(listNameCount);
    return listNameCount;
  }
}
