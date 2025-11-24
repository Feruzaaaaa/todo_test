import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
                  _buildHeader(context),
                  const SizedBox(height: 20),
                  _buildTaskInput(taskController),
                  const SizedBox(height: 12),
                  _buildDatePicker(
                    context,
                    selectedDate,
                        (pickedDate) {
                      setDialogState(() => selectedDate = pickedDate);
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildActionButtons(
                    context,
                    taskController,
                    selectedDate,
                    onTaskCreated,
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

Widget _buildHeader(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'Создание задачи',
        style: GoogleFonts.openSans(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      IconButton(
        icon: const Icon(Icons.close, size: 22),
        onPressed: () => Navigator.pop(context),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    ],
  );
}

Widget _buildTaskInput(TextEditingController controller) {
  return TextField(
    controller: controller,
    style: GoogleFonts.openSans(),
    decoration: InputDecoration(
      hintText: 'Задача',
      hintStyle: GoogleFonts.openSans(
        color: Colors.grey[400],
        fontSize: 15,
      ),
      filled: true,
      fillColor: const Color(0xFFF5F5F5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
    ),
  );
}

Widget _buildDatePicker(
    BuildContext context,
    DateTime? selectedDate,
    Function(DateTime) onDateSelected,
    ) {
  return InkWell(
    onTap: () async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xFF007D88),
              ),
            ),
            child: child!,
          );
        },
      );

      if (picked != null) {
        onDateSelected(picked);
      }
    },
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            selectedDate == null
                ? 'Выберите'
                : DateFormat('dd.MM.yyyy').format(selectedDate),
            style: GoogleFonts.openSans(
              color: selectedDate == null ? Colors.grey[400] : Colors.black,
              fontSize: 15,
            ),
          ),
          Icon(
            Icons.calendar_today_outlined,
            size: 20,
            color: Colors.grey[600],
          ),
        ],
      ),
    ),
  );
}

Widget _buildActionButtons(
    BuildContext context,
    TextEditingController taskController,
    DateTime? selectedDate,
    Function(String, DateTime) onTaskCreated,
    ) {
  return Row(
    children: [
      Expanded(
        child: TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: const Color(0xFFE0E0E0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Отменить',
            style: GoogleFonts.plusJakartaSans(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: TextButton(
          onPressed: () {
            if (taskController.text.isNotEmpty && selectedDate != null) {
              onTaskCreated(taskController.text, selectedDate);
              Navigator.pop(context);
            }
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: const Color(0xFF007D88),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Применить',
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ],
  );
}









