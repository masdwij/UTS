// lib/todo_list_screen.dart

import 'package:flutter/material.dart';
import 'database_helper.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final List<Map<String, dynamic>> _todoItems = [];
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final List<Map<String, dynamic>> todos = await _dbHelper.getTodos();
    setState(() {
      _todoItems.clear();
      _todoItems.addAll(todos);
    });
  }

  Future<void> _addTodoItem(String task) async {
    if (task.isNotEmpty) {
      await _dbHelper.insertTodo(task);
      _textController.clear();
      _loadTodos();
    }
  }

  Future<void> _deleteTodoItem(int id) async {
    await _dbHelper.deleteTodo(id);
    _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To-Do List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Enter a task',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _addTodoItem(_textController.text),
                ),
              ),
              onSubmitted: _addTodoItem,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todoItems.length,
              itemBuilder: (context, index) {
                final item = _todoItems[index];
                return ListTile(
                  title: Text(item['title']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteTodoItem(item['id']),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
