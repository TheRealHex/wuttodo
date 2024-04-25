import 'package:flutter/material.dart';

import '../data/textdata.dart';
import '../style.dart';

Widget buildTodoItem(BuildContext context, TextData data, Widget content) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: ListTile(
              title: Text(data.value),
              titleTextStyle: contentTextStyle(context),
            ),
          ),
          content
        ],
      ),
    ),
  );
}
