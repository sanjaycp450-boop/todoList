import 'package:flutter/material.dart';

class to_do_provider extends ChangeNotifier {
  final List<String> todoList = [];

  List<String> get _todoList => List.unmodifiable(todoList);

  void add_task(String task) {

    if (task.trim().isEmpty) return;
    todoList.add(task.trim());

    notifyListeners();
  }

  void romove_task(int index) {

    todoList.removeAt(index);
    
    notifyListeners();
  }
}
