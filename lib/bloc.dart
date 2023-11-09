import 'dart:async';
import 'package:flutter/material.dart';

enum TaskAction { add, remove }

class Task {
  final String name;

  Task(this.name);
}

class TaskBloc {
  final _taskController = StreamController<List<Task>>.broadcast();

  List<Task> _tasks = [];

  Stream<List<Task>> get tasks => _taskController.stream;

  void handleTask(TaskAction action, Task task) {
    if (action == TaskAction.add) {
      _tasks.add(task);
    } else {
      _tasks.remove(task);
    }

    _taskController.sink.add(_tasks);
  }

  void dispose() {
    _taskController.close();
  }
}

final taskBloc = TaskBloc();
