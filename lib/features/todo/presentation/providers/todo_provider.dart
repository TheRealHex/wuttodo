import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/todo.dart';
import '../../domain/usecases/add_todo.dart';
import '../../domain/usecases/check_toggle.dart';
import '../../domain/usecases/delete_todo.dart';
import '../../domain/usecases/edit_todo.dart';
import '../../domain/usecases/fetch_checked.dart';
import '../../domain/usecases/get_todos.dart';

class TodoProvider with ChangeNotifier {
  final GetTodos getTodos;
  final FetchChecked fetchChecked;
  final CheckToggle checkToggle;
  final AddTodo addTodo;
  final DeleteTodo deleteTodo;
  final EditTodo editTodo;

  List<Todo> _todos = [];
  List<Todo> _checkedTodos = [];
  bool _isLoading = false;

  final Uuid uuid = const Uuid();

  TodoProvider({
    required this.editTodo,
    required this.getTodos,
    required this.addTodo,
    required this.deleteTodo,
    required this.fetchChecked,
    required this.checkToggle,
  });

  List<Todo> get doneTodos => _checkedTodos;
  bool get isLoading => _isLoading;
  List<Todo> get todos => _todos;

  Future<void> loadTodos() async {
    _isLoading = true;
    notifyListeners();

    _todos = await getTodos(); // fetch todos
    _checkedTodos = await fetchChecked();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTodoItem(String text) async {
    final newTodo = Todo(
      id: uuid.v4(),
      text: text,
      isDone: false,
    );

    await addTodo(newTodo);
    await loadTodos();
  }

  Future<void> checkTodo(String id) async {
    await checkToggle(id);
    await loadTodos();
  }

  Future<void> editTodoItem(String id, String newText) async {
    await editTodo(id, newText);
    await loadTodos();
  }

  Future<void> removeTodoItem(String id) async {
    await deleteTodo(id);
    await loadTodos();
  }
}
