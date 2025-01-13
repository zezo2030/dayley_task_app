import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'habpits_model.g.dart';

@HiveType(typeId: 1)
class Habits {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final bool isRepetable;

  @HiveField(2)
  final String id;

  @HiveField(3)
  final TimeOfDay selectedTime;

  @HiveField(4)
  bool isCompleted;

  Habits({
    required this.id,
    required this.title,
    required this.isRepetable,
    required this.selectedTime,
    this.isCompleted = false,
  });
}
