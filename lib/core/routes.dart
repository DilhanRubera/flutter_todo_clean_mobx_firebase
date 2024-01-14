import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_mobx_clean_firebase/data/models/list_model.dart';
import 'package:todo_mobx_clean_firebase/presentation/pages/add_task_page.dart';
import 'package:todo_mobx_clean_firebase/presentation/pages/home_page.dart';

class AppRouter {
  static const homePath = "/";
  static Widget homePageWidget(BuildContext context, GoRouterState state) {
    return const HomePage();
  }

  static const addTaskPath = "/add_task/:listModel";
  static Widget addTaskPageWidget(BuildContext context, GoRouterState state) {
    ListModel listModel = state.extra as ListModel;

    return AddTaskPage(listModel: listModel);
  }

  static final GoRouter _router = GoRouter(routes: [
    GoRoute(path: homePath, builder: homePageWidget),
    GoRoute(path: addTaskPath, builder: addTaskPageWidget),
  ]);

  static GoRouter get router => _router;
}
