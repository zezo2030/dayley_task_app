import 'package:dayley_task_app/models/task_model.dart';
import 'package:dayley_task_app/routes/app_router.dart';
import 'package:dayley_task_app/routes/pages.dart';
import 'package:dayley_task_app/viewmodel/task_view_model.dart';
import 'package:dayley_task_app/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  // hive  تهيئه
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());
  // hive  فتح الصندوق
  const String tasksBox = 'tasks';
  await Hive.openBox<Task>(tasksBox);

  runApp(ChangeNotifierProvider(
    create: (context) => TaskViewModel(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Pages.initial,
      onGenerateRoute: onGenerateRoute,
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        fontFamily: 'Sora',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        canvasColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
