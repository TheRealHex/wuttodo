import 'package:flutter/material.dart';

import '../data/boxes.dart';
import '../data/textdata.dart';
import '../function/todo_function.dart';
import '../style.dart';
import '../widgets/todo_item.dart';

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
    ThemeData theme = Theme.of(context);
    return Semantics(
      label: 'Home',
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Wut Todo?'),
            titleTextStyle: appBarTextStyle(context),
            backgroundColor: theme.colorScheme.background,
            scrolledUnderElevation: 0,
            actions: [
              IconButton(
                onPressed: widget.toggleTheme,
                icon: Icon(
                  Icons.dark_mode,
                  color: theme.colorScheme.surface,
                  semanticLabel: 'Toggle Theme',
                ),
              ),
            ],
          ),
          body: Column(
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
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.background, // Container color
                  borderRadius:
                      BorderRadius.circular(10.0), // Optional rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.background,
                      offset: Offset(0, 1.0), // Shadow offset (x, y)
                      blurRadius: 10.0, // Blur radius of the shadow
                      spreadRadius:
                          12.0, // Spread radius to enlarge the shadow (optional)
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 10, top: 4),
                  child: _inputCheckAdd(),
                ),
              ),
            ],
          ),
          // floatingActionButton: floatingBtn(context),
        ),
      ),
    );
  }

// To-do input | Checklist | Add Btn
  Row _inputCheckAdd() {
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
              hintText: 'Go for a hike!',
              hintStyle: labelTextStyle(context),
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
            // _saveTask();
            setState(() {
              TodoFunction().save(_textController);
            });
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
                if (!regex.hasMatch(_textController.text)) {
                  setState(() {
                    TodoFunction().replace(index, _textController);
                    _textController.clear();
                  });
                }
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
                  TodoFunction().check(index, true);
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
                  TodoFunction().delete(index);
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
