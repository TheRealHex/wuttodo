import 'package:WutTodo/widgets/todo_item.dart';
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
    return Semantics(
      label: 'Home',
      child: GestureDetector(
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
                  color: Theme.of(context).colorScheme.surface,
                  semanticLabel: 'Toggle Theme',
                ),
              ),
            ],
          ),
          body: Container(
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.background),
            child: Center(
              child: Column(
                children: [
                  // Display inserted text and icons to check & delete
                  const SizedBox(height: 16),
                  Flexible(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: boxTodo.length,
                      itemBuilder: (context, index) {
                        return _fetchList(context, index);
                      },
                    ),
                  ),

                  // Text input and insert icon
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _searchadd(),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          // floatingActionButton: floatingBtn(context),
        ),
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
            style: contentTextStyle(context),
            controller: _textController,
            cursorColor: Theme.of(context).colorScheme.surface,
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.all(10),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.surface),
              ),
              labelText: 'Go for a hike!',
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.bold,
              ),
              counterText: '',
            ),
            maxLength: 100,
            scrollPhysics: BouncingScrollPhysics(),
            onSubmitted: (value) {
              inputValue = value;
            },
          ),
        ),
        IconButton(
          onPressed: () => Navigator.pushNamed(context, '/checked'),
          icon: Icon(
            Icons.checklist,
            color: Theme.of(context).colorScheme.surface,
            semanticLabel: 'Completed List',
          ),
        ),
        IconButton(
          onPressed: () {
            _saveTask();
            FocusScope.of(context).unfocus();
          },
          icon: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.surface,
            semanticLabel: 'Add todo',
          ),
        ),
      ],
    );
  }

  void _saveTask() {
    final text =
        _textController.text.trim(); // Remove leading/trailing whitespaces
    if (text.isNotEmpty && !boxTodo.containsKey('key_$text')) {
      // Replace multiple spaces with a single space (optional)
      final _cleanText = text.replaceAll(RegExp(r'\s\s+'), ' ');
      setState(() {
        boxTodo.put('key_$text', TextData(value: _cleanText, completed: false));
        _textController.clear();
      });
    }
  }

  // Display list of the input Todo items
  Widget _fetchList(BuildContext context, int index) {
    TextData data = boxTodo.getAt(index)!;
    if (data.completed == false) {
      return buildTodoItem(
        context,
        data,
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
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
