import 'package:hive/hive.dart';

part 'textdata.g.dart';

@HiveType(typeId: 1)
class TextData {
  TextData({
    required this.value,
    required this.completed,
  }) : time = DateTime.now();

  @HiveField(0)
  String value;

  @HiveField(1)
  bool completed;

  @HiveField(2)
  DateTime time;
}
