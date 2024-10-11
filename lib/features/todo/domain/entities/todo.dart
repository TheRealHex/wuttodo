import 'package:wuttodo/features/todo/data/models/todo_model.dart';

class Todo {
  final String id, text;
  final bool isDone;

  Todo({required this.id, required this.text, this.isDone = false});

  TodoModel toModel() {
    return TodoModel(id: id, text: text, isDone: isDone);
  }
}
