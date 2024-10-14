import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/style.dart';
import '../handlers/build_listview.dart';
import '../providers/todo_provider.dart';

class TodoChecked extends StatelessWidget {
  const TodoChecked({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) {
        final ThemeData theme = Theme.of(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Checked'),
            scrolledUnderElevation: 0,
            backgroundColor: theme.colorScheme.onSurface,
            titleTextStyle: appBarTextStyle(context),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                semanticLabel: 'Go back',
              ),
              color: theme.colorScheme.surface,
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                onPressed: () => Navigator.pushNamed(context, '/about'),
                icon: const Icon(
                  Icons.extension_outlined,
                  semanticLabel: 'About',
                ),
                color: theme.colorScheme.surface,
              )
            ],
          ),
          body: Container(
            color: theme.colorScheme.onSurface,
            child: Column(
              children: [
                const SizedBox(height: 5),
                Flexible(
                  child: buildListView(false, todoProvider, theme, null),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
