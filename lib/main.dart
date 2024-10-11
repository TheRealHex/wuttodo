import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'features/todo/data/data_sources/todo_local_source.dart';
import 'features/todo/data/models/todo_model.dart';
import 'features/todo/data/repos/todo_repo_impl.dart';
import 'features/todo/domain/usecases/add_todo.dart';
import 'features/todo/domain/usecases/check_toggle.dart';
import 'features/todo/domain/usecases/delete_todo.dart';
import 'features/todo/domain/usecases/edit_todo.dart';
import 'features/todo/domain/usecases/fetch_checked.dart';
import 'features/todo/domain/usecases/get_todos.dart';
import 'features/todo/presentation/pages/todo_about.dart';
import 'features/todo/presentation/pages/todo_checked.dart';
import 'features/todo/presentation/pages/todo_home.dart';
import 'features/todo/presentation/providers/theme_provider.dart';
import 'features/todo/presentation/providers/todo_provider.dart';
import 'theme/theme_constants.dart';

void main() async {
  // init hive
  await Hive.initFlutter();

  // register the adapter
  Hive.registerAdapter(TodoModelAdapter());

  // open box
  await Hive.openBox<TodoModel>('todos');

  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    final localSource = TodoLocalSourceImpl();
    final repo = TodoRepoImpl(localSource);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (_) => TodoProvider(
            getTodos: GetTodos(repo),
            fetchChecked: FetchChecked(repo),
            addTodo: AddTodo(repo),
            deleteTodo: DeleteTodo(repo),
            editTodo: EditTodo(repo),
            checkToggle: CheckToggle(repo),
          )..loadTodos(),
        )
      ],
      child: Builder(
        builder: (context) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            theme: themeProvider.isDarkTheme ? darkTheme : lightTheme,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (_) => const TodoHome(),
              '/checked': (_) => const TodoChecked(),
              '/about': (_) => const TodoAbout(),
            },
          );
        },
      ),
    );
  }
}
