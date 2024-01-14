import 'package:flutter/material.dart';
import 'package:todo_mobx_clean_firebase/core/routes.dart';
import 'package:todo_mobx_clean_firebase/presentation/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_mobx_clean_firebase/presentation/stores/listnames_store.dart';
import 'package:todo_mobx_clean_firebase/presentation/stores/tasks_store.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter binding is initialized

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ListNamesStore>(
          create: (_) => ListNamesStore(),
        ),
        Provider<TasksStore>(
          create: (_) => TasksStore(),
        )
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
        //darkTheme: ThemeData(brightness: Brightness.dark),
        //
        routerConfig: AppRouter.router,
      ),
    );
  }
}
