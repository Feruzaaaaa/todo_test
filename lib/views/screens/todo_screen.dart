import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../models/task_model.dart';
import '../../viewmodels/todo_view_model.dart';
import '../widgets/dialogs/create_task_dialog.dart';
import '../widgets/cards/todo_status_card.dart';
import '../widgets/items/draggable_task_item.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<TodoViewModel>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TodoViewModel>();

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
                child: _buildTasksList(viewModel),
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

  Widget _buildTasksList(TodoViewModel viewModel) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (int i = 0; i < viewModel.statuses.length; i++) ...[
            _buildStatusSection(viewModel.statuses[i], viewModel),
            if (i != viewModel.statuses.length - 1)
              const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusSection(String status, TodoViewModel viewModel) {
    final tasks = viewModel.tasksForStatus(status);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DragTarget<Task>(
          onAcceptWithDetails: (details) {
            viewModel.updateTaskStatus(details.data, status);
          },
          builder: (context, candidateData, rejectedData) {
            return TodoStatusCard(
              title: status,
              count: tasks.length,
              isExpanded: viewModel.isExpanded(status),
              onTap: () => viewModel.toggleSection(status),
              isHighlighted: candidateData.isNotEmpty,
            );
          },
        ),

        if (viewModel.isExpanded(status))
          Column(
            children: tasks
                .map(
                  (task) => DraggableTaskItem(
                      task: task,
                      onDelete: viewModel.deleteTask,
                    ),
                  )
                .toList(),
          ),
      ],
    );
  }

  void _showCreateTaskDialog() {
    final viewModel = context.read<TodoViewModel>();
    showCreateTaskDialog(
      context: context,
      onTaskCreated: (String title, DateTime date) {
        viewModel.addTask(title, date);
      },
    );
  }
}

