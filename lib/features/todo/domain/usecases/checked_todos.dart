import '../entities/todo.dart';
import '../repos/todo_repo.dart';

class CheckedTodos {
  final TodoRepo repo;

  CheckedTodos(this.repo);

  Future<List<Todo>> call() async {
    // debugPrint('test');
    return await repo.checkedTodos();
  }
}
