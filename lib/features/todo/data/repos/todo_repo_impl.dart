import '../../domain/entities/todo.dart';
import '../../domain/repos/todo_repo.dart';
import '../data_sources/todo_local_source.dart';
import '../models/todo_model.dart';

class TodoRepoImpl implements TodoRepo {
  final TodoLocalSource localSource;
  TodoRepoImpl(this.localSource);

  @override
  Future<void> addTodo(TodoModel todo) async {
    await localSource.addTodo(todo);
  }

  @override
  Future<void> checkToggle(String id) async {
    await localSource.checkToggle(id);
  }

  @override
  Future<void> deleteTodo(String id) async {
    await localSource.deleteTodo(id);
  }

  @override
  Future<void> editTodo(String id, String newText) async {
    await localSource.editTodo(id, newText);
  }

  @override
  Future<List<Todo>> fetchChecked() async {
    final todos = await localSource.fetchChecked();
    // Convert TodoModel list to Todo list
    return todos
        .map((todoModel) => Todo(
              id: todoModel.id,
              text: todoModel.text,
              isDone: todoModel.isDone,
            ))
        .toList();
  }

  @override
  Future<Todo> getTodoById(String id) async {
    return await localSource.getTodoById(id) as Todo;
  }

  @override
  Future<List<Todo>> getTodos() async {
    final todos = await localSource.getTodos();
    // Convert TodoModel list to Todo list
    return todos
        .map((todoModel) => Todo(
              id: todoModel.id,
              text: todoModel.text,
              isDone: todoModel.isDone,
            ))
        .toList();
  }
}
