import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/style.dart';
import '../providers/todo_provider.dart';
import '../widgets/action_btns.dart';

class TodoChecked extends StatelessWidget {
  const TodoChecked({super.key});

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    final ThemeData theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Checked'),
          scrolledUnderElevation: 0,
          backgroundColor: Theme.of(context).colorScheme.onSurface,
          titleTextStyle: appBarTextStyle(context),
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                semanticLabel: 'Go back',
              ),
              color: Theme.of(context).colorScheme.surface,
              onPressed: () => Navigator.pop(context)),
          actions: [
            IconButton(
              onPressed: () => {Navigator.pushNamed(context, '/about')},
              icon: const Icon(
                Icons.info_outline,
                semanticLabel: 'About',
              ),
              color: Theme.of(context).colorScheme.surface,
            )
          ],
        ),
        body: Container(
            color: theme.colorScheme.onSurface,
            child: Column(children: [
              Flexible(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: todoProvider.doneTodos.length,
                      itemBuilder: (context, index) {
                        final todo = todoProvider.doneTodos[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: theme.colorScheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            child: ListTile(
                              title: Text(todo.text),
                              titleTextStyle: contentTextStyle(context),
                              trailing: actionBtns(context, todo, null, false),
                            ),
                          ),
                        );
                      }))
            ])));
    // Text input and insert icon
  }
}
