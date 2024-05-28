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
  late List<TextData> allItems = [];

  final _textController = TextEditingController();

  late String inputValue;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Semantics(
      label: 'Home',
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Wut Todo?'),
            titleTextStyle: appBarTextStyle(context),
            backgroundColor: theme.colorScheme.onSurface,
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
          body: Container(
            color: theme.colorScheme.onSurface,
            child: Column(
              children: [
                // Display inserted text and icons to check & delete
                const SizedBox(height: 16),
                Flexible(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: allItems.where((item) => !item.completed).length,
                    itemBuilder: (context, index) {
                      return _fetchList(context, index);
                    },
                  ),
                ),

                // Text input and insert icon
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurface, // Container color
                    borderRadius:
                        BorderRadius.circular(10.0), // Optional rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.onSurface,
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
          ),
          // floatingActionButton: floatingBtn(context),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Call updateAllItems whenever dependencies change
    updateAllItems();
  }

  @override
  void initState() {
    super.initState();
    allItems = boxTodo.values.toList().cast();
  }

  void updateAllItems() {
    setState(() {
      allItems = boxTodo.values.toList().cast();
    });
  }

  // Display list of the input Todo items
  Widget _fetchList(BuildContext context, int index) {
    final List<TextData> remainingItems =
        allItems.where((item) => !item.completed).toList().cast();
    remainingItems.sort((b, a) => a.time.compareTo(b.time));
    final originalIndex = allItems.indexOf(remainingItems[index]);
    final TextData textData = remainingItems[index];

    return buildTodoItem(
      context,
      textData,
      Row(
        children: [
          // replace button
          IconButton(
            onPressed: () {
              final RegExp regex = RegExp(r'^\s*$');
              if (!regex.hasMatch(_textController.text)) {
                TodoFunction().replace(originalIndex,
                    _textController); // passing TextData object instead of index
                _textController.clear();
                updateAllItems();
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
              TodoFunction().check(originalIndex,
                  true); // passing TextData object instead of index
              updateAllItems();
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
              TodoFunction().delete(
                  originalIndex); // passing TextData object instead of index
              updateAllItems();
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
            TodoFunction().save(_textController);
            updateAllItems();
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
}
