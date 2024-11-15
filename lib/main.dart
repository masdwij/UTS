// lib/main.dart

import 'package:flutter/material.dart';
import 'todo_list_screen.dart';

void main() => runApp(TodoListApp());

class TodoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TodoListScreen(),
    );
  }
}
