// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habpits_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitsAdapter extends TypeAdapter<Habits> {
  @override
  final int typeId = 1;

  @override
  Habits read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Habits(
      id: fields[2] as String,
      title: fields[0] as String,
      isRepetable: fields[1] as bool,
      selectedTime: fields[3] as TimeOfDay,
      isCompleted: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Habits obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.isRepetable)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.selectedTime)
      ..writeByte(4)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
