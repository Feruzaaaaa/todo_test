import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../models/task_model.dart';
import '../services/storage_service.dart';

class TodoViewModel extends ChangeNotifier {
  static const List<String> _statuses = [
    'К выполнению',
    'В работе',
    'На проверке',
    'Выполнено',
  ];

  final StorageService _storageService;
  final Map<String, List<Task>> _tasksByStatus = {
    for (final status in _statuses) status: <Task>[],
  };
  final Map<String, bool> _expandedSections = {
    for (final status in _statuses) status: false,
  };

  ValueListenable<Box<Task>>? _tasksListenable;
  bool _isInitialized = false;

  TodoViewModel({StorageService? storageService})
      : _storageService = storageService ?? StorageService();

  List<String> get statuses => List.unmodifiable(_statuses);

  void initialize() {
    if (_isInitialized) return;
    _tasksListenable = _storageService.listenable();
    _tasksListenable!.addListener(_handleTasksChanged);
    _syncTasks();
    _isInitialized = true;
  }

  List<Task> tasksForStatus(String status) {
    return List.unmodifiable(_tasksByStatus[status] ?? <Task>[]);
  }

  bool isExpanded(String status) => _expandedSections[status] ?? false;

  void toggleSection(String status) {
    final current = _expandedSections[status] ?? false;
    _expandedSections[status] = !current;
    notifyListeners();
  }

  Future<void> addTask(String title, DateTime date) async {
    final task = Task(
      title: title,
      date: date,
      status: _statuses.first,
    );
    await _storageService.addTask(task);
  }

  Future<void> updateTaskStatus(Task task, String newStatus) async {
    task.status = newStatus;
    await _storageService.updateTask(task);
  }

  Future<void> deleteTask(Task task) async {
    await _storageService.deleteTask(task);
  }

  @override
  void dispose() {
    _tasksListenable?.removeListener(_handleTasksChanged);
    super.dispose();
  }

  void _handleTasksChanged() {
    _syncTasks();
    notifyListeners();
  }

  void _syncTasks() {
    for (final status in _statuses) {
      _tasksByStatus[status] = _storageService.getTasksByStatus(status);
    }
  }
}

