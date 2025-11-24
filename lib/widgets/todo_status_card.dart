import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/task_model.dart';
import 'draggable_task_item.dart';

class TodoStatusCard extends StatelessWidget {
  final String title;
  final int count;
  final bool isExpanded;
  final VoidCallback onTap;
  final List<Task> tasks;
  final Function(Task, String) onStatusChange;
  final bool isHighlighted;

  const TodoStatusCard({
    Key? key,
    required this.title,
    required this.count,
    required this.isExpanded,
    required this.onTap,
    required this.tasks,
    required this.onStatusChange,
    this.isHighlighted = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isHighlighted
            ? Border.all(color: const Color(0xFF007D88), width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeader(),
          if (isExpanded) _buildTasksList(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Text(
                  count.toString(),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 12),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.black,
                  size: 24,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTasksList() {
    return Column(
      children: tasks
          .map((task) => DraggableTaskItem(
        task: task,
        onStatusChange: onStatusChange,
      ))
          .toList(),
    );
  }
}