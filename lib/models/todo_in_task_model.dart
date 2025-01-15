

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'todo_in_task_model.g.dart';

@HiveType(typeId: 2)
class TodoInTaskModel{
  @HiveField(0)
  String taskId;

  @HiveField(1)
  String todoTitle;

  @HiveField(2)
  bool isCompleted;

  @HiveField(3)
  TimeOfDay todoTime;


  TodoInTaskModel({
    required this.taskId,
    required this.todoTitle,
    required this.isCompleted,
    required this.todoTime,
  });
}