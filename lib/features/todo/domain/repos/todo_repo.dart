import '../../data/models/todo_model.dart';
import '../entities/todo.dart';

abstract class TodoRepo {
  Future<void> addTodo(TodoModel todo); // Add a new todo
  Future<void> deleteTodo(String id); // Delete todo by id
  Future<void> editTodo(String id, String newText); // Edit todo by id
  Future<List<Todo>> getTodos(); // Fetch a list of todos
  Future<List<Todo>> fetchChecked(); // Fetch a list of checked todos
  Future<Todo> getTodoById(String id);
  Future<void> checkToggle(String id); // check or uncheck todo
}
