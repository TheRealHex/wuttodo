import 'package:WutTodo/widgets/todo_item.dart';
import 'package:flutter/material.dart';

import '../data/boxes.dart';
import '../data/textdata.dart';
import '../function/todo_function.dart';
import '../style.dart';

class Checked extends StatefulWidget {
  Checked({super.key});

  @override
  State<Checked> createState() => _CheckedState();
}

class _CheckedState extends State<Checked> {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Completed Tasks',
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Noice!'),
              SizedBox(width: 5),
              Icon(
                Icons.check_circle,
                color: Theme.of(context).colorScheme.surface,
                size: 22,
              )
            ],
          ),
          scrolledUnderElevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
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
                Icons.question_mark,
                semanticLabel: 'About',
              ),
              color: Theme.of(context).colorScheme.surface,
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 16),
            Flexible(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount:
                    boxTodo.values.where((data) => data.completed).length,
                itemBuilder: (context, index) {
                  return _fetchList(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fetchList(int index) {
    // Find the correct index of the completed item in the boxTodo box
    int completedIndex = 0;
    int boxIndex = 0;

    while (completedIndex <= index && boxIndex < boxTodo.length) {
      if (boxTodo.getAt(boxIndex)?.completed ?? false) {
        completedIndex++;
      }
      boxIndex++;
    }
    boxIndex--;

    // Get the TextData object at the correct index
    TextData data = boxTodo.getAt(boxIndex)!;

    if (data.completed) {
      return buildTodoItem(
        context,
        data,
        Row(children: [
          // Uncheck icon
          IconButton(
            onPressed: () =>
                setState(() => TodoFunction().check(boxIndex, false)),
            icon: const Icon(
              Icons.checklist_rtl,
              semanticLabel: 'Uncheck todo',
            ),
            color: Colors.blue[300],
          ),
          // Delete button
          IconButton(
            onPressed: () => setState(() => TodoFunction().delete(boxIndex)),
            icon: const Icon(
              Icons.delete,
              semanticLabel: 'Delete todo',
            ),
            color: Colors.red[300],
          ),
        ]),
      );
    } else {
      return SizedBox();
    }
  }
}
