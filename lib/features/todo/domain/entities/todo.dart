class Todo {
  final String id, text;
  final bool isDone;

  Todo({required this.id, required this.text, this.isDone = false});

  // copy-with method
  Todo copyWith({
    String? id,
    String? text,
    bool? isDone,
  }) {
    return Todo(
      id: id ?? this.id,
      text: text ?? this.text,
      isDone: isDone ?? this.isDone,
    );
  }
}
