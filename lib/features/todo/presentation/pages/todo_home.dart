import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/style.dart';
import '../providers/theme_provider.dart';
import '../providers/todo_provider.dart';
import '../widgets/action_btns.dart';

class TodoHome extends StatelessWidget {
  const TodoHome({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return Consumer2<TodoProvider, ThemeProvider>(
      builder: (context, todoProvider, themeProvider, child) {
        final ThemeData theme = Theme.of(context);

        return Scaffold(
          backgroundColor: theme.colorScheme.onSurface,
          appBar: AppBar(
            title: const Text('Wut Todo?'),
            titleTextStyle: appBarTextStyle(context),
            backgroundColor: theme.colorScheme.onSurface,
            scrolledUnderElevation: 0,
            actions: [
              IconButton(
                onPressed: () => themeProvider.toggleTheme(),
                icon: Icon(
                  Icons.dark_mode,
                  color: theme.colorScheme.surface,
                  semanticLabel: 'Toggle Theme',
                ),
              ),
            ],
          ),
          body: Container(
            color: theme.colorScheme.onSurface,
            child: Column(
              children: [
                Flexible(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: todoProvider.todos.length,
                        itemBuilder: (context, index) {
                          final todo = todoProvider.todos[index];
                          return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 12.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.secondaryContainer,
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                                child: ListTile(
                                  title: Text(todo.text),
                                  titleTextStyle: contentTextStyle(context),
                                  trailing: actionBtns(
                                      todoProvider, true, todo, textController),
                                ),
                              ));
                        })),
                // Text input and insert icon
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurface, // Container color
                    borderRadius:
                        BorderRadius.circular(10.0), // Optional rounded corners
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, bottom: 10, top: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: TextField(
                            style: contentTextStyle(context),
                            controller: textController,
                            cursorColor: theme.colorScheme.primary,
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              contentPadding: const EdgeInsets.all(10),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.surface),
                              ),
                              hintText: 'Go for a hike!',
                              hintStyle: labelTextStyle(context),
                              counterText: '',
                            ),
                            maxLength: 100,
                            scrollPhysics: const BouncingScrollPhysics(),
                            onSubmitted: (value) {
                              value;
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/checked'),
                          icon: Icon(
                            Icons.checklist,
                            color: Theme.of(context).colorScheme.surface,
                            semanticLabel: 'Completed List',
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            final inputText = textController.text.trim();
                            if (inputText.isNotEmpty &&
                                !todoProvider.todos
                                    .any((todo) => todo.text == inputText)) {
                              Provider.of<TodoProvider>(context, listen: false)
                                  .addTodoItem(inputText);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      duration: Duration(seconds: 2),
                                      content:
                                          Text('Todo exists or is empty')));
                            }
                            textController.clear();
                            FocusScope.of(context).unfocus();
                          },
                          icon: Icon(
                            Icons.add,
                            color: Theme.of(context).colorScheme.surface,
                            semanticLabel: 'Add todo',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
