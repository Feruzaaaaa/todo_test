import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/task_model.dart';

class StorageService {
  static const String _boxName = 'tasks';

  // Получить Box с задачами
  Box<Task> get _box => Hive.box<Task>(_boxName);

  ValueListenable<Box<Task>> listenable() {
    return _box.listenable();
  }

  // Получить все задачи
  List<Task> getAllTasks() {
    return _box.values.toList();
  }

  // Добавить задачу
  Future<void> addTask(Task task) async {
    await _box.add(task);
  }

  // Обновить задачу
  Future<void> updateTask(Task task) async {
    await task.save();
  }

  // Удалить задачу
  Future<void> deleteTask(Task task) async {
    await task.delete();
  }

  // Получить задачи по статусу
  List<Task> getTasksByStatus(String status) {
    return _box.values.where((task) => task.status == status).toList();
  }

  // Очистить все задачи
  Future<void> clearAll() async {
    await _box.clear();
  }
}