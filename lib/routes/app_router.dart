import 'package:dayley_task_app/routes/pages.dart';
import 'package:dayley_task_app/views/add_habit/add_habite_screen.dart';
import 'package:dayley_task_app/views/create_task_screen.dart';
import 'package:dayley_task_app/views/home/home_screen.dart';
import 'package:dayley_task_app/views/home/home_screen_v1.dart';
import 'package:dayley_task_app/views/page_no_fount.dart';
import 'package:dayley_task_app/views/splash_screen.dart';
import 'package:dayley_task_app/views/task_details_screen.dart';
import 'package:dayley_task_app/views/update_task.dart';
import 'package:flutter/material.dart';

Route onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Pages.initial:
      return MaterialPageRoute(builder: (_) => const SplashScreen());

    case Pages.home:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case Pages.home1:
      return MaterialPageRoute(builder: (_) => const HomeScreenV1());
    case Pages.addHabite:
      return MaterialPageRoute(builder: (_) => const AddHabiteScreen());

    case Pages.createTask:
      return MaterialPageRoute(builder: (_) => const CreateTaskScreen());
    case Pages.updateTask:
      return MaterialPageRoute(builder: (_) => const UpdateTask());
    case Pages.taskDetails:
      return MaterialPageRoute(builder: (_) => const TaskDetailsScreen());
    default:
      return MaterialPageRoute(builder: (_) => const PageNotFound());
  }
}
