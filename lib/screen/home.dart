import 'dart:io';

import 'package:flutter/material.dart';

import '../constants.dart';
import '../style.dart';

class Home extends StatefulWidget {
  final VoidCallback toggleTheme;
  Home({required this.toggleTheme});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _textController = TextEditingController();
  final List<String> todoList = [];
  final List<String> checkedList = [];
  late String inputValue;

  @override
  void initState() {
    super.initState();
    getPaths();
    _loadTask();
  }

  void refreshState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wut Todo?'),
        titleTextStyle: appBarTextStyle(context),
        backgroundColor: Theme.of(context).colorScheme.background,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            onPressed: widget.toggleTheme,
            icon: Icon(
              Icons.dark_mode,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
      body: Container(
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.background),
        child: Center(
          child: Column(children: [
            const SizedBox(height: 30),

            // Text input and insert icon
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _searchadd(),
            ),

            // Display inserted text and icons to check & delete
            const SizedBox(height: 10),
            Text(error), // if error on getPath()
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: todoList.length,
                  itemBuilder: (context, index) {
                    return _fetchList(context, index);
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
      floatingActionButton: floatingBtn(context),
    );
  }

// Search bar & add entry
  Row _searchadd() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: TextField(
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            controller: _textController,
            cursorColor: Theme.of(context).colorScheme.primary,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.background)),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary),
              ),
              hintText: 'Go for a hike!',
            ),
            onChanged: (value) {
              inputValue = value;
            },
          ),
        ),
        IconButton(
            onPressed: () {
              _saveTask(todoPath);
              _loadTask();
            },
            icon: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.primary,
            )),
      ],
    );
  }

  void _saveTask(String path) {
    final task = _textController.text;

    // check if the task isn't empty & not already in todoList for duplicates
    if (task.isNotEmpty && !todoList.contains(task)) {
      todoList.add(task);
      final file = File(path);

      //Read existing content
      String existingContent = '';
      if (file.existsSync()) {
        existingContent = file.readAsStringSync();
      }

      //Append new todo
      final updateContent = '$existingContent\n$task';

      // Write the updated content back to file
      file.writeAsStringSync(updateContent);

      _textController.clear();
    }
  }

  void _loadTask() {
    final file = File(todoPath);

    if (file.existsSync()) {
      final content = file.readAsStringSync();
      setState(() {
        todoList.clear();
        todoList.addAll(
            content.split('\n').where((task) => task.trim().isNotEmpty));
      });
    }
  }

  void _editTask(int index) {
    final String inputValue = _textController.text;
    if (inputValue.isNotEmpty) {
      todoList[index] = inputValue;

      final file = File(todoPath);
      file.writeAsStringSync(todoList.join('\n'));

      _textController.clear();
    }
  }

  void _completeTask(int index) {
    String completed = todoList[index];
    todoList.removeAt(index);
    checkedList.add(completed);

    // Save into files
    final todoFile = File(todoPath);
    todoFile.writeAsStringSync(todoList.join('\n'));
    final doneFile = File(donePath);
    doneFile.writeAsStringSync('$completed\n', mode: FileMode.append);

    // Refresh the screen
    refreshState();
  }

  void _deleteTask(int index) {
    if (todoList.isNotEmpty) {
      todoList.removeAt(index);

      // save the file
      final file = File(todoPath);
      file.writeAsStringSync(todoList.join('\n'));
    }
  }

  // Display list of the input Todo items
  Row _fetchList(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          // width: MediaQuery.of(context).size.width / 1.4,
          child: ListTile(
              title: Text(todoList[index]),
              textColor: Theme.of(context).colorScheme.secondary),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                _editTask(index);
                refreshState();
              },
              icon: const Icon(Icons.find_replace),
              color: Colors.blueGrey[300],
            ),
            IconButton(
              onPressed: () {
                _completeTask(index);
                refreshState();
              },
              icon: const Icon(Icons.check),
              color: Colors.blue[300],
            ),
            IconButton(
              onPressed: () {
                _deleteTask(index);
                refreshState();
              },
              icon: const Icon(Icons.delete),
              color: Colors.red[300],
            ),
          ],
        )
      ],
    );
  }

  // Button to browse checked list
  FloatingActionButton floatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        await Navigator.pushNamed(
          context,
          '/checked',
          arguments: {
            'checkedList': checkedList,
          },
        ).then((result) {
          if (result == true) {
            _loadTask();
          }
        });
      },
      child: Icon(
        Icons.checklist,
        color: Theme.of(context).colorScheme.background,
      ),
    );
  }
}
