import '../repos/todo_repo.dart';

class CheckToggle {
  final TodoRepo repo;

  CheckToggle(this.repo);

  Future<void> call(String id) async {
    await repo.checkToggle(id);
  }
}
