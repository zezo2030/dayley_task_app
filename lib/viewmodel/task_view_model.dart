import 'package:dayley_task_app/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskViewModel extends ChangeNotifier {
  // open box
  final Box<Task> _taskBox = Hive.box<Task>('tasks');

  // get tasks
  List<Task> get tasks => _taskBox.values.toList();

  Task? _selectedTask;
  // get selected task
  Task? get selectedTask => _selectedTask;

  // set selected task
  void setSelectedTask(Task task) {
    _selectedTask = task;
    notifyListeners();
  }

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

  // not working

// Future<void> updateTask(
//   Task updatedTask,
// ) async {
//   if (_selectedTask != null) {
//     await _taskBox.put(_selectedTask!.id, updatedTask);
//     _selectedTask = updatedTask;
//     notifyListeners();
//   }
// }

  Future<void> updateTask(Task updatedTask) async {
    final taskIndex = tasks.indexWhere((task) => task.id == updatedTask.id);
    if (taskIndex != -1) {
      await _taskBox.putAt(taskIndex, updatedTask);
      _selectedTask = updatedTask;
      notifyListeners();
    }
  }

  // void updateTaskProgress(String taskId, double progress) {
  //   final taskIndex =
  //       _taskBox.values.toList().indexWhere((task) => task.id == taskId);
  //   if (taskIndex != -1) {
  //     Task task = _taskBox.getAt(taskIndex)!;
  //     task.progress = progress;
  //     _taskBox.putAt(taskIndex, task);
  //     notifyListeners();
  //   }
  // }

  Future<void> updateTaskProgress(String taskId, double progress) async {
    final taskIndex = tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      Task task = tasks[taskIndex];
      task.progress = progress;
      await _taskBox.putAt(taskIndex, task);
      notifyListeners();
    }
  }

  Future<void> updateTaskCompletion(String taskId, bool isCompleted) async {
    final taskIndex = tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      Task task = tasks[taskIndex];
      task.isCompleted = isCompleted;
      await _taskBox.putAt(taskIndex, task);
      notifyListeners();
    }
  }
}
