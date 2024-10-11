import '../entities/todo.dart';
import '../repos/todo_repo.dart';

class FetchChecked {
  final TodoRepo repo;

  FetchChecked(this.repo);

  Future<List<Todo>> call() async {
    return await repo.fetchChecked();
  }
}
