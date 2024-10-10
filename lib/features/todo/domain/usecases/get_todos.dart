import '../entities/todo.dart';
import '../repos/todo_repo.dart';

class GetTodos {
  final TodoRepo repo;

  GetTodos(this.repo);

  Future<List<Todo>> call() async {
    return await repo.getTodos();
  }
}
