import 'package:flutter/material.dart';
import 'components/date_picker_field.dart';
import 'components/dialog_action_buttons.dart';
import 'components/dialog_header.dart';
import 'components/task_input_field.dart';

void showCreateTaskDialog({
  required BuildContext context,
  required Function(String title, DateTime date) onTaskCreated,
}) {
  final TextEditingController taskController = TextEditingController();
  DateTime? selectedDate;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          final bool showTaskLabel =
              taskController.text.trim().isNotEmpty;
          final bool showDateLabel = selectedDate != null;
          return Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CreateTaskDialogHeader(
                    onClose: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 20),
                  TaskInputField(
                    controller: taskController,
                    showLabel: showTaskLabel,
                    onChanged: (_) => setDialogState(() {}),
                  ),
                  const SizedBox(height: 12),
                  DatePickerField(
                    selectedDate: selectedDate,
                    showLabel: showDateLabel,
                    onDateSelected: (pickedDate) {
                      setDialogState(() => selectedDate = pickedDate);
                    },
                  ),
                  const SizedBox(height: 20),
                  CreateTaskDialogActions(
                    onCancel: () => Navigator.pop(context),
                    onSubmit: () {
                      onTaskCreated(taskController.text, selectedDate!);
                      Navigator.pop(context);
                    },
                    isSubmitEnabled:
                        taskController.text.isNotEmpty && selectedDate != null,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}









