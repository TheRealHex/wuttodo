import 'package:hive/hive.dart';

part 'textdata.g.dart';

@HiveType(typeId: 1)
class TextData {
  TextData({required this.value, required this.completed});

  @HiveField(0)
  String value;

  @HiveField(1)
  bool completed;
}
