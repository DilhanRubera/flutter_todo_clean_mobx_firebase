import 'package:mobx/mobx.dart';
import 'package:todo_mobx_clean_firebase/data/models/list_model.dart';
import 'package:todo_mobx_clean_firebase/data/repositories/add_new_listname_repo_impl.dart';
import 'package:todo_mobx_clean_firebase/data/repositories/get_all_listnames_repo_impl.dart';

part 'listnames_store.g.dart';

class ListNamesStore extends _ListNamesStore with _$ListNamesStore {}

enum ListNamesStoreState { noLists, haveLists }

abstract class _ListNamesStore with Store {
  // @observable
  // ObservableFuture<List<ListModel>> futureNewList = ObservableFuture.value([]);

  // late ObservableFuture<List<ListModel>> futureNewList=[];

  // Future<int> initialListCount = ObservableFuture.value(0);

  // @observable
  // //int listCount = 0;

  // @observable
  // List<ListModel> newList = [];

  // @computed
  // ListNamesStoreState get state {
  //   if (newList.isNotEmpty) {
  //     print("loaded gets called");
  //     return ListNamesStoreState.loaded;
  //   } else if (newList.isEmpty) {
  //     print("initial gets called");
  //     return ListNamesStoreState.inital;
  //   }
  //   return ListNamesStoreState.loading;
  // }

  // @action
  // getListNameCount() async {
  //   print("initial list count $listCount");
  //   initialListCount = AddNewListRepositoryImpl().getListNameCount();
  //   listCount = await initialListCount;
  //   print("this gets called");
  //   print("store new list num $listCount");
  // }

  @observable
  ObservableList<ListModel> newList = ObservableList<ListModel>();

  @observable
  late String message;

  @computed
  ListNamesStoreState get state {
    if (newList.isEmpty) {
      print("noo lists");
      return ListNamesStoreState.noLists;
    } else {
      print("have  lists");
      return ListNamesStoreState.haveLists;
    }
  }

  @action
  Future<ObservableList<ListModel>> getAllListsNames() async {
    try {
      newList = ObservableList<ListModel>.of(
          await GetAllListNamesRepoImpl().getAllListNames());
      print("got all the names store");
      //newList = await futureNewList;
    } catch (e) {
      print("Error getting all list names store $e");
    }

    return newList;
  }

  @action
  addNewList(String name) async {
    try {
      message = "";
      ListModel newListObject =
          await AddNewListRepositoryImpl().addNewList(name);

      newList.add(newListObject);
      print("added a new list name storeeeee");
      for (int i = 0; i < newList.length; i++) {
        print(newList[i].listName);
        print("this worked");

        print("added a new list name store");
        message = "Added List sucessfully";
      }
    } catch (e) {
      print("Error adding a new list name store $e");
      message = "Error adding a new list - $e";
    }
  }
}
