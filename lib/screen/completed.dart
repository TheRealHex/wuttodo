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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noice!'),
        backgroundColor: Theme.of(context).colorScheme.background,
        titleTextStyle: appBarTextStyle(context),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () => Navigator.popAndPushNamed(context, '/')),
        actions: [
          IconButton(
            onPressed: () => {Navigator.pushNamed(context, '/about')},
            icon: Icon(
              Icons.question_mark,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: boxTodo.values.where((data) => data.completed).length,
        itemBuilder: (context, index) {
          return _fetchList(index);
        },
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.celebration,
              color: Colors.amber[300],
            ),
            Flexible(
              child: ListTile(
                title: Text(data.value),
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
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
              icon: const Icon(Icons.checklist_rtl),
              color: Colors.blue[300],
            ),
            // Delete button
            IconButton(
              onPressed: () {
                setState(() {
                  boxTodo.deleteAt(boxIndex);
                });
              },
              icon: const Icon(Icons.delete),
              color: Colors.red[300],
            ),
          ],
        ),
      );
    } else {
      return Padding(padding: EdgeInsets.all(0));
    }
  }
}
