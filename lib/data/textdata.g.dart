// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'textdata.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TextDataAdapter extends TypeAdapter<TextData> {
  @override
  final int typeId = 1;

  @override
  TextData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TextData(
      value: fields[0] as String,
      completed: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TextData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.value)
      ..writeByte(1)
      ..write(obj.completed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TextDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
