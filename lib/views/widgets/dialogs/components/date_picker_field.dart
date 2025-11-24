import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatelessWidget {
  final DateTime? selectedDate;
  final bool showLabel;
  final ValueChanged<DateTime> onDateSelected;

  const DatePickerField({
    super.key,
    required this.selectedDate,
    required this.showLabel,
    required this.onDateSelected,
  });

  static const Color _activeBorderColor = Color(0xFF007D88);
  static const Color _inactiveBorderColor = Color(0xFFD0D5DD);

  @override
  Widget build(BuildContext context) {
    final bool isActive = selectedDate != null;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: () => _pickDate(context),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 18,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isActive ? _activeBorderColor : _inactiveBorderColor,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate == null
                      ? 'Выберите дату'
                      : DateFormat('dd.MM.yyyy').format(selectedDate!),
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
        ),
        if (showLabel)
          Positioned(
            left: 20,
            top: -12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              color: const Color(0xFFF9FAFA),
              child: Text(
                'Дата завершения',
                style: GoogleFonts.openSans(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: _activeBorderColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onDateSelected(picked);
    }
  }
}

