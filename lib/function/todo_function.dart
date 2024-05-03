import 'package:flutter/material.dart';

import '../data/boxes.dart';
import '../data/textdata.dart';

class TodoFunction {
  void save(TextEditingController textController) {
    final text = textController.text.trim();
    if (text.isNotEmpty && !boxTodo.containsKey('key_$text')) {
      final _cleanText = text.replaceAll(RegExp(r'\s\s+'), ' ');
      boxTodo.put(
        'key_$text',
        TextData(
          value: _cleanText,
          completed: false,
        ),
      );
      textController.clear();
    }
  }

  void delete(int index) {
    final keys = boxTodo.keys.toList();
    if (index >= 0 && index < keys.length) {
      boxTodo.delete(keys[index]);
    }
  }

  void check(int index, bool value) {
    final keys = boxTodo.keys.toList();
    if (index >= 0 && index < keys.length) {
      final key = keys[index];
      final textData = boxTodo.get(key);
      if (textData != null) {
        boxTodo.put(
          key,
          TextData(
            value: textData.value,
            completed: value,
          ),
        );
      }
    }
  }

  void replace(int index, TextEditingController textController) {
    final keys = boxTodo.keys.toList();
    if (index >= 0 && index < keys.length) {
      final key = keys[index];
      final newText = textController.text.trim();
      if (newText.isNotEmpty) {
        boxTodo.put(
          key,
          TextData(
            value: newText,
            completed: false,
          ),
        );
      }
    }
  }
}

