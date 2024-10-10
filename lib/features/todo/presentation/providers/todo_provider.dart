import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:wuttodo/features/todo/domain/usecases/checked_todos.dart';

import '../../domain/entities/todo.dart';
import '../../domain/usecases/add_todo.dart';
import '../../domain/usecases/delete_todo.dart';
import '../../domain/usecases/edit_todo.dart';
import '../../domain/usecases/get_todos.dart';

class TodoProvider with ChangeNotifier {
  final GetTodos getTodos;
  final CheckedTodos checkedTodos;
  final AddTodo addTodo;
  final DeleteTodo deleteTodo;
  final EditTodo editTodo;

  List<Todo> _todos = [];
  List<Todo> _checkedTodos = [];
  bool _isLoading = false;

  TodoProvider({
    required this.editTodo,
    required this.getTodos,
    required this.addTodo,
    required this.deleteTodo,
    required this.checkedTodos,
  });

  bool get isLoading => _isLoading;
  List<Todo> get doneTodos => _checkedTodos;
  List<Todo> get todos => _todos;
  final Uuid uuid = const Uuid();

  Future<void> addTodoItem(String text) async {
    final newTodo = Todo(
      id: uuid.v4(),
      text: text,
      isDone: false,
    );
    await addTodo(newTodo);
    await loadTodos();
  }

  Future<void> editTodoItem(String id, String newText) async {
    await editTodo(id, newText);
    _todos = await getTodos();
    notifyListeners();
  }

  Future<void> loadTodos() async {
    _isLoading = true;
    notifyListeners();
    _todos = await getTodos();
    _checkedTodos = await checkedTodos();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> removeTodoItem(String id) async {
    await deleteTodo(id);
    await loadTodos();
  }

  Future<void> checkTodo() async {}
}
