import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/todo.dart';
import '../providers/todo_provider.dart';

Row actionBtns(BuildContext context, Todo todo,
    TextEditingController? textController, bool isHome) {
  final todoProvider = Provider.of<TodoProvider>(context);

  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <IconButton>[
      isHome
          ? IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.done),
              color: Colors.blue[300],
              iconSize: 23,
            )
          : IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.checklist),
              color: Colors.red[300],
              iconSize: 23,
            ),
      IconButton(
        onPressed: () {
          // print(inputText);
          todoProvider.editTodoItem(todo.id, textController!.text);
        },
        icon: const Icon(Icons.find_replace_outlined),
        color: Colors.blueGrey[300],
        iconSize: 23,
      ),
      IconButton(
        onPressed: () => todoProvider.removeTodoItem(todo.id),
        icon: const Icon(Icons.delete),
        color: Colors.red[300],
        iconSize: 23,
      ),
    ],
  );
}
