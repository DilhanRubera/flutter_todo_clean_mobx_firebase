import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_mobx_clean_firebase/data/models/list_model.dart';
import 'package:todo_mobx_clean_firebase/domain/repositories/get_all_listnames_repository.dart';

class GetAllListNamesRepoImpl implements GetAllListNamesRepository {
  @override
  Future<List<ListModel>> getAllListNames() async {
    List<ListModel> listDetails = [];
    try {
      //List<Map<String, dynamic>> listDetails;

      QuerySnapshot<Map<String, dynamic>> listColection =
          await FirebaseFirestore.instance.collection('lists').get();
      for (QueryDocumentSnapshot documentSnapshot in listColection.docs) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        // String listName = data['listName'];
        // int noOfTasks = data['noOfTasks'];
        listDetails.add(ListModel.fromJson(data));

        //listDetails.add
      }
      print("got all the list names repo");
    } catch (e) {
      print("Error getting all list names repo $e");
    }
    for (int i = 0; i < listDetails.length; i++) {
      print("repo doc id ${listDetails[i].listId}");
      print("repo doc name ${listDetails[i].listName}");
      print("repo doc no of taks ${listDetails[i].noOfTasks}");
    }
    return listDetails;
  }
}
