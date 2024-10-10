import '../../data/models/todo_model.dart';
import '../entities/todo.dart';
import '../repos/todo_repo.dart';

class AddTodo {
  final TodoRepo repo;

  AddTodo(this.repo);

  Future<void> call(Todo todo) async {
    // Convert Todo to TodoModel
    final todoModel = TodoModel(
      id: todo.id,
      text: todo.text,
      isDone: todo.isDone,
    );
    await repo.addTodo(todoModel);
  }
}
