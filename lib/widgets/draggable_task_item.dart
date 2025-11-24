import 'package:flutter/material.dart';
import '../models/task_model.dart';
import 'task_item_content.dart';

class DraggableTaskItem extends StatelessWidget {
  final Task task;
  final Function(Task, String) onStatusChange;

  const DraggableTaskItem({
    Key? key,
    required this.task,
    required this.onStatusChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double feedbackWidth = constraints.maxWidth - 20;

        return LongPressDraggable<Task>(
          data: task,
          feedback: _buildFeedback(feedbackWidth),
          childWhenDragging: Opacity(
            opacity: 0.3,
            child: TaskItemContent(task: task),
          ),
          child: TaskItemContent(task: task),
        );
      },
    );
  }

  Widget _buildFeedback(double width) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: width,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: TaskItemContent(
            task: task,
            isCompact: true,
          ),
        ),
      ),
    );
  }
}