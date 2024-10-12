import '../../data/models/todo_model.dart';

class Todo {
  final String id, text;
  bool isDone;

  Todo({required this.id, required this.text, this.isDone = false});

  TodoModel toModel() {
    return TodoModel(id: id, text: text, isDone: isDone);
  }
}
