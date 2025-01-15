import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ColorAdapter extends TypeAdapter<Color> {
  @override
  final int typeId = 2; // Unique ID for this adapter

  @override
  Color read(BinaryReader reader) {
    final int value = reader.readInt();
    return Color(value);
  }

  @override
  void write(BinaryWriter writer, Color obj) {
    writer.writeInt(obj.value);
  }
}
