import 'package:wuttodo/features/todo/data/data_sources/todo_local_source.dart';
import 'package:wuttodo/features/todo/data/models/todo_model.dart';
import 'package:wuttodo/features/todo/domain/entities/todo.dart';
import 'package:wuttodo/features/todo/domain/repos/todo_repo.dart';

class TodoRepoImpl implements TodoRepo {
  final TodoLocalSource localSource;
  TodoRepoImpl(this.localSource);

  @override
  Future<void> addTodo(TodoModel todo) async {
    await localSource.addTodo(todo);
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

  @override
  Future<List<Todo>> checkedTodos() async {
    final todos = await localSource.checkedTodos();
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
