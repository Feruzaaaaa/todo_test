import 'package:flutter/material.dart';

import '../../../models/task_model.dart';
import '../cards/task_item_content.dart';

class DraggableTaskItem extends StatelessWidget {
  final Task task;
  final Future<void> Function(Task task) onDelete;

  const DraggableTaskItem({
    super.key,
    required this.task,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double feedbackWidth = constraints.maxWidth - 20;

        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      await onDelete(task);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/icons/trash-one.png',
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            "Удалить",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: Container(
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: LongPressDraggable<Task>(
              data: task,
              feedback: _buildFeedback(feedbackWidth),
              childWhenDragging: Opacity(
                opacity: 0.3,
                child: TaskItemContent(
                  task: task,
                  titleFontSize: 18,
                ),
              ),
              child: TaskItemContent(
                task: task,
                titleFontSize: 18,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeedback(double width) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(22),
      child: SizedBox(
        width: width,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
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
            titleFontSize: 18,
          ),
        ),
      ),
    );
  }
}

