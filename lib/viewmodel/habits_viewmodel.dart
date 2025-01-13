import 'package:dayley_task_app/models/habpits_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HabitesViewModel extends ChangeNotifier {
  // open box
  final Box<Habits> _habitsBox = Hive.box<Habits>('habits');

  // get habits
  List<Habits> get habits => _habitsBox.values.toList();

  // add habit
  Future<void> addHabit(Habits habit) async {
    await _habitsBox.add(habit);
    notifyListeners();
  }


  // get nmper of completed habits and nou completed habits
  int get numberOfCompletedHabits =>
      _habitsBox.values.where((habit) => habit.isCompleted).length;

   persentageOfCompletedHabits() {
    if (_habitsBox.values.isEmpty) {
      return 0;
    }
    return (numberOfCompletedHabits / _habitsBox.values.length);
  }


  // check and update habits at end of day
  Future<void> checkAndUpdateHabits() async {
    final today = DateTime.now();
    final endOfDay = DateTime(today.year, today.month, today.day, 23, 59, 59);

    if (DateTime.now().isAfter(endOfDay)) {
      for (int i = 0; i < _habitsBox.length; i++) {
        Habits habit = _habitsBox.getAt(i)!;

        if (habit.isCompleted) {
          if (!habit.isRepetable) {
            // Delete non-repeatable completed habits
            await _habitsBox.deleteAt(i);
          } else {
            // Reset repeatable habits for the next day
            habit.isCompleted = false;
            await _habitsBox.putAt(i, habit);
          }
        }
      }
      notifyListeners();
    }
  }

  // toggle habit complection
  Future<void> toggleHabitComplection(int index) async {
    Habits habit = _habitsBox.getAt(index)!;
    habit.isCompleted = !habit.isCompleted; // Toggle instead of setting to true
    await _habitsBox.putAt(index, habit);
    notifyListeners();
  }

  // delete habit
  Future<void> deleteHabit(int index) async {
    await _habitsBox.deleteAt(index);
    notifyListeners();
  }
}
