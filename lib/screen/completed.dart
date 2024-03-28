import 'dart:io';

import 'package:flutter/material.dart';

import '../constants.dart';
import '../style.dart';

// ignore: must_be_immutable
class Checked extends StatefulWidget {
  Checked({
    super.key,
    required this.checkedList,
  });
  List<String> checkedList = [];

  @override
  State<Checked> createState() => _CheckedState();
}

class _CheckedState extends State<Checked> {
  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  void refresh() {
    setState(() {});
  }

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
            onPressed: () => Navigator.pop(context, true)),
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
        itemCount: widget.checkedList.length,
        itemBuilder: (context, index) {
          return _fetchList(index);
        },
      ),
    );
  }

  Padding _fetchList(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.cake,
            color: Colors.amber[400],
          ),
          Flexible(
            child: ListTile(
              title: Text(widget.checkedList[index]),
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),

          // Uncheck icon
          IconButton(
            onPressed: () {
              if (widget.checkedList.isNotEmpty) {
                String completed = widget.checkedList[index];
                widget.checkedList.removeAt(index);

                // Save into files
                final doneFile = File(donePath);
                doneFile.writeAsStringSync(widget.checkedList.join('\n'));

                // Append to todo list with a new line
                final todoFile = File(todoPath);
                final todoContent =
                    todoFile.existsSync() ? todoFile.readAsStringSync() : '';
                final updatedTodoContent = '$todoContent\n$completed';
                todoFile.writeAsStringSync(updatedTodoContent);

                setState(() {});
              }
            },
            icon: const Icon(Icons.checklist_rtl),
            color: Colors.blue[300],
          ),

          // Delete button
          IconButton(
            onPressed: () {
              setState(() {
                if (widget.checkedList.isNotEmpty) {
                  widget.checkedList.removeAt(index);

                  // save the file
                  final file = File(donePath);
                  file.writeAsStringSync(widget.checkedList.join('\n'));
                }
              });
            },
            icon: const Icon(Icons.delete),
            color: Colors.red[300],
          ),
        ],
      ),
    );
  }

  void _loadTask() {
    final file = File(donePath);

    if (file.existsSync()) {
      setState(() {
        final content = file.readAsStringSync();
        widget.checkedList.addAll(
            content.split('\n').where((task) => task.trim().isNotEmpty));
      });
    }
  }
}
