// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_in_task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoInTaskModelAdapter extends TypeAdapter<TodoInTaskModel> {
  @override
  final int typeId = 4;

  @override
  TodoInTaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoInTaskModel(
      taskId: fields[0] as String,
      todoTitle: fields[1] as String,
      isCompleted: fields[2] as bool,
      todoTime: fields[3] as TimeOfDay,
    );
  }

  @override
  void write(BinaryWriter writer, TodoInTaskModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.taskId)
      ..writeByte(1)
      ..write(obj.todoTitle)
      ..writeByte(2)
      ..write(obj.isCompleted)
      ..writeByte(3)
      ..write(obj.todoTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoInTaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
