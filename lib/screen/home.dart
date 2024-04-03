import 'package:flutter/material.dart';

import '../data/boxes.dart';
import '../data/textdata.dart';
import '../style.dart';

class Home extends StatefulWidget {
  final VoidCallback toggleTheme;
  Home({required this.toggleTheme});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _textController = TextEditingController();
  late String inputValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                color: Theme.of(context).colorScheme.primary,
                semanticLabel: 'Toggle Theme',
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
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: boxTodo.length,
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
      ),
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
            _saveTask();
            FocusScope.of(context).unfocus();
          },
          icon: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.primary,
            semanticLabel: 'Add todo',
          ),
        ),
      ],
    );
  }

  void _saveTask() {
    final RegExp regex = RegExp(r'^\s*$');
    // check if the task isn't empty & not already in todoList for duplicates
    if (!regex.hasMatch(_textController.text)) {
      setState(() {
        boxTodo.put(
          'key_${_textController.text}',
          TextData(value: _textController.text, completed: false),
        );
        _textController.clear();
      });
    }
  }

  // Display list of the input Todo items
  Row _fetchList(BuildContext context, int index) {
    TextData data = boxTodo.getAt(index)!;
    if (data.completed == false) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: ListTile(
              title: Text(data.value),
              textColor: Theme.of(context).colorScheme.secondary,
            ),
          ),
          Row(
            children: [
              // replace button
              IconButton(
                onPressed: () {
                  final RegExp regex = RegExp(r'^\s*$');
                  setState(() {
                    if (!regex.hasMatch(_textController.text)) {
                      boxTodo.putAt(
                          index,
                          TextData(
                            value: _textController.text,
                            completed: false,
                          ));
                      _textController.clear();
                    }
                  });
                },
                icon: const Icon(
                  Icons.find_replace,
                  semanticLabel: 'Replace entry',
                ),
                color: Colors.blueGrey[300],
              ),

              // task-completed button
              IconButton(
                onPressed: () {
                  setState(() {
                    boxTodo.putAt(
                      index,
                      TextData(
                        value: data.value,
                        completed: true,
                      ),
                    );
                  });
                },
                icon: const Icon(
                  Icons.check,
                  semanticLabel: 'Task complete',
                ),
                color: Colors.blue[300],
              ),

              // delete button
              IconButton(
                onPressed: () {
                  setState(() {
                    boxTodo.deleteAt(index);
                  });
                },
                icon: const Icon(
                  Icons.delete,
                  semanticLabel: 'Delete todo',
                ),
                color: Colors.red[300],
              ),
            ],
          )
        ],
      );
    } else {
      return Row();
    }
  }

  // Button to browse checked list
  FloatingActionButton floatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, '/checked'),
      child: Icon(
        Icons.checklist,
        color: Theme.of(context).colorScheme.background,
      ),
    );
  }
}
