import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/task_model.dart';
import '../services/storage_service.dart';
import '../widgets/create_task_dialog.dart';
import '../widgets/todo_status_card.dart';
import '../widgets/draggable_task_item.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final StorageService _storageService = StorageService();

  final Map<String, bool> _expandedSections = {
    'К выполнению': false,
    'В работе': false,
    'На проверке': false,
    'Выполнено': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 32),
              Expanded(
                child: _buildTasksList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Todo',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 30,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFF007D88),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 32,
            ),
            onPressed: _showCreateTaskDialog,
          ),
        ),
      ],
    );
  }

  Widget _buildTasksList() {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Task>('tasks').listenable(),
      builder: (context, Box<Task> box, _) {
        return SingleChildScrollView(
          child: Column(
            children: [
              _buildStatusSection('К выполнению'),
              const SizedBox(height: 12),
              _buildStatusSection('В работе'),
              const SizedBox(height: 12),
              _buildStatusSection('На проверке'),
              const SizedBox(height: 12),
              _buildStatusSection('Выполнено'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusSection(String status) {
    final tasks = _storageService.getTasksByStatus(status);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DragTarget<Task>(
          onAcceptWithDetails: (details) {
            _changeTaskStatus(details.data, status);
          },
          builder: (context, candidateData, rejectedData) {
            return TodoStatusCard(
              title: status,
              count: tasks.length,
              isExpanded: _expandedSections[status]!,
              onTap: () {
                setState(() {
                  _expandedSections[status] = !_expandedSections[status]!;
                });
              },
              isHighlighted: candidateData.isNotEmpty,
            );
          },
        ),

        // ⭐ ЗАДАЧИ ТЕПЕРЬ НИЖЕ КАРТОЧКИ (не внутри неё)
        if (_expandedSections[status]!)
          Column(
            children: tasks
                .map(
                  (task) => DraggableTaskItem(
                task: task,
                onStatusChange: _changeTaskStatus,
              ),
            )
                .toList(),
          ),
      ],
    );
  }

  void _showCreateTaskDialog() {
    showCreateTaskDialog(
      context: context,
      onTaskCreated: (String title, DateTime date) async {
        final task = Task(
          title: title,
          date: date,
          status: 'К выполнению',
        );
        await _storageService.addTask(task);
      },
    );
  }

  void _changeTaskStatus(Task task, String newStatus) async {
    task.status = newStatus;
    await _storageService.updateTask(task);
  }
}

