import 'package:flutter/material.dart';

import '../data/boxes.dart';
import '../data/textdata.dart';

class TodoFunction {
  void save(TextEditingController textController) {
    final text =
        textController.text.trim(); // Remove leading/trailing whitespaces
    if (text.isNotEmpty && !boxTodo.containsKey('key_$text')) {
      // Replace multiple spaces with a single space (optional)
      final _cleanText = text.replaceAll(RegExp(r'\s\s+'), ' ');
      boxTodo.put(
          'key_$text',
          TextData(
            value: _cleanText,
            completed: false,
          ));
      // Clear Text Field
      textController.clear();
    }
  }

  // Delete entry
  void delete(int index) {
    boxTodo.deleteAt(index);
  }

  // Check / Un-check todo item
  void check(int index, bool value) {
    boxTodo.putAt(
        index,
        TextData(
          value: boxTodo.getAt(index).value,
          completed: value,
        ));
  }

  // replace todo entry
  void replace(int index, TextEditingController textController) {
    boxTodo.putAt(
        index,
        TextData(
          value: textController.text,
          completed: false,
        ));
  }
}
