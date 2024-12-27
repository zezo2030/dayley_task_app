import 'package:dayley_task_app/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskViewModel extends ChangeNotifier {
  // open box
  final Box<Task> _taskBox = Hive.box<Task>('tasks');
  // get tasks
  List<Task> get tasks => _taskBox.values.toList();

  // add task
  Future<void> addTask(Task task) async {
    await _taskBox.add(task);
    notifyListeners();
  }

  Future<void> toggleTaskComplection(int index) async {
    Task task = _taskBox.getAt(index)!;
    task.isCompleted = !task.isCompleted;
    await _taskBox.putAt(index, task);
    notifyListeners();
  }

  Future<void> deleteTask(int index) async {
    await _taskBox.deleteAt(index);
    notifyListeners();
  }

  Future<void> updateTask(int index, Task updatedTask) async {
    //await _taskBox.deleteAt(index);
    await _taskBox.putAt(index, updatedTask);
    notifyListeners();
  }
}
