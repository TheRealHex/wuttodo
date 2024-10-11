import 'package:hive/hive.dart';
import 'package:wuttodo/features/todo/domain/entities/todo.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0) // Unique ID for the type adapter
class TodoModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String text;

  @HiveField(2)
  final bool isDone;

  TodoModel({
    required this.id,
    required this.text,
    this.isDone = false,
  });

  Todo toEntity() {
    return Todo(
      id: id,
      text: text,
      isDone: isDone,
    );
  }

  TodoModel copyWith({String? id, String? text, bool? isDone}) {
    return TodoModel(
      id: id ?? this.id,
      text: text ?? this.text,
      isDone: isDone ?? this.isDone,
    );
  }
}
