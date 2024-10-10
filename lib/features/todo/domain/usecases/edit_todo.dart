import '../repos/todo_repo.dart';

class EditTodo {
  final TodoRepo repo;

  EditTodo(this.repo);

  Future<void> call(String id, String newText) async {
    await repo.editTodo(id, newText);
  }
}
