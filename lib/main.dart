import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/todo_item.dart';
import 'package:todo_app/todo_list_page.dart';
import 'package:todo_app/todo_service.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoItemAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final TodoService _todoService = TodoService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
            future: _todoService.getAllToDos(),
            builder:
                (BuildContext context, AsyncSnapshot<List<TodoItem>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return TodoListPage(snapshot.data ?? []);
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }
}
