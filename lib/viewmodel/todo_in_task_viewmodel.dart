import 'package:dayley_task_app/models/todo_in_task_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TodoInTaskViewModel extends ChangeNotifier {
  final Box<TodoInTaskModel> _todoBox = Hive.box<TodoInTaskModel>('todos');

  List<TodoInTaskModel> get todos => _todoBox.values.toList();

  Future<void> add(TodoInTaskModel todo) async {
    await _todoBox.add(todo);
    notifyListeners();
  }

  Future<void> remove(int index) async {
    await _todoBox.deleteAt(index);
    notifyListeners();
  }

  Future<void> toggle(int index) async {
    TodoInTaskModel todo = _todoBox.getAt(index)!;
    todo.isCompleted = !todo.isCompleted;
    await _todoBox.putAt(index, todo);
    notifyListeners();
  }
}
