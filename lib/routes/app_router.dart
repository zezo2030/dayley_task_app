import 'package:dayley_task_app/routes/pages.dart';
import 'package:dayley_task_app/views/create_task_screen.dart';
import 'package:dayley_task_app/views/home_screen.dart';
import 'package:dayley_task_app/views/page_no_fount.dart';
import 'package:dayley_task_app/views/splash_screen.dart';
import 'package:dayley_task_app/views/update_task.dart';
import 'package:flutter/material.dart';

Route onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Pages.initial:
      return MaterialPageRoute(builder: (_) => const SplashScreen());

    case Pages.home:
      return MaterialPageRoute(builder: (_) => const HomeScreen());

    case Pages.createTask:
      return MaterialPageRoute(builder: (_) => const CreateTaskScreen());
    case Pages.updateTask:
      return MaterialPageRoute(builder: (_) => const UpdateTask());
    default:
      return MaterialPageRoute(builder: (_) => const PageNotFound());
  }
}
