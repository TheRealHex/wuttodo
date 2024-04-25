import 'package:flutter/material.dart';

import '../data/boxes.dart';
import '../data/textdata.dart';
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
              const Text('Congrats!'),
              const SizedBox(width: 5),
              Icon(
                Icons.celebration,
                color: Colors.amber[300],
              ),
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

  Padding _fetchList(int index) {
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
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: ListTile(
                  title: Text(data.value),
                  textColor: Theme.of(context).colorScheme.surface,
                  titleTextStyle: contentTextStyle(context),
                ),
              ),
              // Uncheck icon
              IconButton(
                onPressed: () {
                  setState(() {
                    boxTodo.putAt(
                      boxIndex,
                      TextData(value: data.value, completed: false),
                    );
                  });
                },
                icon: const Icon(
                  Icons.checklist_rtl,
                  semanticLabel: 'Uncheck todo',
                ),
                color: Colors.blue[300],
              ),
              // Delete button
              IconButton(
                onPressed: () {
                  setState(() {
                    boxTodo.deleteAt(boxIndex);
                  });
                },
                icon: const Icon(
                  Icons.delete,
                  semanticLabel: 'Delete todo',
                ),
                color: Colors.red[300],
              ),
            ],
          ),
        ),
      );
    } else {
      return Padding(padding: EdgeInsets.all(0));
    }
  }
}
