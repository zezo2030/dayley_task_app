import 'package:dayley_task_app/adapters/color_adapter.dart';
import 'package:dayley_task_app/models/habpits_model.dart';
import 'package:dayley_task_app/models/task_model.dart';
import 'package:dayley_task_app/models/time_of_day_adabter.dart';
import 'package:dayley_task_app/models/todo_in_task_model.dart';
import 'package:dayley_task_app/routes/app_router.dart';
import 'package:dayley_task_app/routes/pages.dart';
import 'package:dayley_task_app/viewmodel/task_view_model.dart';
import 'package:dayley_task_app/viewmodel/todo_in_task_viewmodel.dart';
import 'package:dayley_task_app/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:dayley_task_app/viewmodel/habits_viewmodel.dart';

void main() async {
  // hive  تهيئه
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(HabitsAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());
  Hive.registerAdapter(ColorAdapter());
  Hive.registerAdapter(TodoInTaskModelAdapter());

  // hive  فتح الصندوق
  const String tasksBox = 'tasks';
  const String habitsBox = 'habits';
  const String todosBox = 'todos';

  await Hive.openBox<Task>(tasksBox);
  await Hive.openBox<Habits>(habitsBox);
  await Hive.openBox<TodoInTaskModel>(todosBox);

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      saveLocale: true,
      useOnlyLangCode: true,
      useFallbackTranslations: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TaskViewModel()),
          ChangeNotifierProvider(create: (_) => TodoInTaskViewModel()),
          ChangeNotifierProvider(
              create: (_) => HabitesViewModel()..checkAndUpdateHabits()),
        ],
        child: const MyApp(),
      ),
    ),
  );
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
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
