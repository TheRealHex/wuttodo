import 'package:flutter/material.dart';

import '../../../../core/constants/style.dart';
import '../providers/todo_provider.dart';
import 'action_btns.dart';

ListView buildListView(bool isHome, TodoProvider todoProvider, ThemeData theme,
    TextEditingController? textController) {
  return ListView.builder(
    physics: const BouncingScrollPhysics(),
    itemCount:
        isHome ? todoProvider.todos.length : todoProvider.doneTodos.length,
    itemBuilder: (context, index) {
      final todo =
          isHome ? todoProvider.todos[index] : todoProvider.doneTodos[index];
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: ListTile(
              title: Text(todo.text),
              titleTextStyle: contentTextStyle(context),
              trailing: isHome
                  ? actionBtns(true, todoProvider, todo, textController)
                  : actionBtns(false, todoProvider, todo, null)),
        ),
      );
    },
  );
}
