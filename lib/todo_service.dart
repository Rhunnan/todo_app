import 'package:hive/hive.dart';
import "todo_item.dart";

class TodoService {
  final String _boxName = "todoBox";

  Future<Box<TodoItem>> get _box async => await Hive.openBox(_boxName);

  Future<void> addItem(TodoItem todoItem) async {
    var box = await _box;
    await box.add(todoItem);
  }

  Future<List<TodoItem>> getAllToDos() async {
    var box = await _box;
    return box.values.toList();
  }

  Future<void> deleteTodo(int index) async {
    var box = await _box;
    await box.deleteAt(index);
  }

  Future<void> updateIsCompleted(int index, TodoItem todoItem) async {
    var box = await _box;
    todoItem.isCompleted = !todoItem.isCompleted;
    await box.putAt(index, todoItem);
  }
}
