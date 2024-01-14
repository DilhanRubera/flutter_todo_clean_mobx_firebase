// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listnames_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ListNamesStore on _ListNamesStore, Store {
  Computed<ListNamesStoreState>? _$stateComputed;

  @override
  ListNamesStoreState get state =>
      (_$stateComputed ??= Computed<ListNamesStoreState>(() => super.state,
              name: '_ListNamesStore.state'))
          .value;

  late final _$newListAtom =
      Atom(name: '_ListNamesStore.newList', context: context);

  @override
  ObservableList<ListModel> get newList {
    _$newListAtom.reportRead();
    return super.newList;
  }

  @override
  set newList(ObservableList<ListModel> value) {
    _$newListAtom.reportWrite(value, super.newList, () {
      super.newList = value;
    });
  }

  late final _$messageAtom =
      Atom(name: '_ListNamesStore.message', context: context);

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

  late final _$getAllListsNamesAsyncAction =
      AsyncAction('_ListNamesStore.getAllListsNames', context: context);

  @override
  Future<ObservableList<ListModel>> getAllListsNames() {
    return _$getAllListsNamesAsyncAction.run(() => super.getAllListsNames());
  }

  late final _$addNewListAsyncAction =
      AsyncAction('_ListNamesStore.addNewList', context: context);

  @override
  Future addNewList(String name) {
    return _$addNewListAsyncAction.run(() => super.addNewList(name));
  }

  @override
  String toString() {
    return '''
newList: ${newList},
message: ${message},
state: ${state}
    ''';
  }
}
