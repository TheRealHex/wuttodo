import 'package:flutter/material.dart';

import '../../domain/entities/todo.dart';
import '../providers/todo_provider.dart';

Row actionBtns(
  bool isHome,
  TodoProvider todoProvider,
  Todo todo,
  TextEditingController? textController,
) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      // Conditionally render buttons based on isHome
      if (isHome) ...[
        _buildEditButton(todoProvider, todo, textController!),
        _buildCheckButton(todoProvider, todo),
      ] else ...[
        _buildCheckButton(todoProvider, todo,
            icon: Icons.checklist, color: Colors.blueGrey[300]),
      ],
      _buildDeleteButton(todoProvider, todo),
    ],
  );
}

// Helper method to build the check button
IconButton _buildCheckButton(TodoProvider todoProvider, Todo todo,
    {IconData? icon, Color? color}) {
  return IconButton(
    onPressed: () => todoProvider.checkTodo(todo.id),
    icon: Icon(icon ?? Icons.done), // Default to the done icon if none provided
    color: color ?? Colors.blue[300], // Default color if none provided
    iconSize: 23,
  );
}

// Helper method to build the delete button
IconButton _buildDeleteButton(TodoProvider todoProvider, Todo todo) {
  return IconButton(
    onPressed: () => todoProvider.removeTodoItem(todo.id),
    icon: const Icon(Icons.delete),
    color: Colors.red[300],
    iconSize: 23,
  );
}

// Helper method to build the edit button
IconButton _buildEditButton(TodoProvider todoProvider, Todo todo,
    TextEditingController textController) {
  return IconButton(
    onPressed: () {
      if (textController.text.trim().isNotEmpty) {
        todoProvider.editTodoItem(todo.id, textController.text);
      }
      textController.clear();
    },
    icon: const Icon(Icons.find_replace_outlined),
    color: Colors.blueGrey[300],
    iconSize: 23,
  );
}
