import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0) // Unique ID for the type adapter
class TodoModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String text;

  @HiveField(2)
  bool isDone;

  TodoModel({
    required this.id,
    required this.text,
    this.isDone = false,
  });
}
