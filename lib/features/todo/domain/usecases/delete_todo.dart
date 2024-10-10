import '../repos/todo_repo.dart';

class DeleteTodo {
  final TodoRepo repo;

  DeleteTodo(this.repo);

  Future<void> call(String id) async {
    await repo.deleteTodo(id);
  }
}
