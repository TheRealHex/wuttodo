import 'package:hive/hive.dart';

import '../models/todo_model.dart';

abstract class TodoLocalSource {
  Future<void> addTodo(TodoModel todo);
  Future<void> checkToggle(String id);
  Future<void> deleteTodo(String id);
  Future<void> editTodo(String id, String newText);
  Future<TodoModel> getTodoById(String id);
  Future<List<TodoModel>> fetchChecked();
  Future<List<TodoModel>> getTodos();
}

class TodoLocalSourceImpl implements TodoLocalSource {
  final Box<TodoModel> _todoBox = Hive.box<TodoModel>('todos');

  @override
  Future<void> addTodo(TodoModel todo) async {
    await _todoBox.add(todo);
  }

  @override
  Future<void> checkToggle(String id) async {
    final index = _todoBox.values.toList().indexWhere((todo) => todo.id == id);

    if (index != -1) {
      final existingTodo =
          _todoBox.getAt(index) as TodoModel; // cast to TodoModel
      existingTodo.isDone = !existingTodo.isDone;

      await _todoBox.putAt(index, existingTodo);
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todoIndex =
        _todoBox.values.toList().indexWhere((todo) => todo.id == id);
    if (todoIndex != -1) {
      await _todoBox.deleteAt(todoIndex);
    }
  }

  @override
  Future<void> editTodo(String id, String newText) async {
    if (newText.isNotEmpty) {
      // Find key for todo
      final keys = _todoBox.keys.toList();

      for (var key in keys) {
        final existingTodo = _todoBox.get(key) as TodoModel;

        // Check the right todo to edit
        if (existingTodo.id == id) {
          // Update the todo text
          existingTodo.text = newText;

          // save data in box
          await _todoBox.put(key, existingTodo);
          break;
        }
      }
    }
  }

  @override
  Future<List<TodoModel>> fetchChecked() async {
    return _todoBox.values
        .where((todo) => todo.isDone)
        .toList()
        .cast<TodoModel>();
  }

  @override
  Future<TodoModel> getTodoById(String id) async {
    return _todoBox.values.firstWhere((todo) => todo.id == id);
  }

  @override
  Future<List<TodoModel>> getTodos() async {
    return _todoBox.values
        .where((todo) => !todo.isDone)
        .toList()
        .cast<TodoModel>();
  }
}
