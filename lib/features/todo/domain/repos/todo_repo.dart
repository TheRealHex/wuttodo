import '../../data/models/todo_model.dart';
import '../entities/todo.dart';

abstract class TodoRepo {
  Future<void> addTodo(TodoModel todo); // Add a new todo
  Future<void> deleteTodo(String id); // Delete todo by id
  Future<void> editTodo(String id, String newText); // Edit todo by id
  Future<List<Todo>> getTodos(); // Fetch a list of todos
  Future<List<Todo>> checkedTodos(); // Fetch a list of todos
}
