import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool showLabel;
  final ValueChanged<String> onChanged;

  const TaskInputField({
    super.key,
    required this.controller,
    required this.showLabel,
    required this.onChanged,
  });

  static const Color _activeBorderColor = Color(0xFF007D88);
  static const Color _inactiveBorderColor = Color(0xFFD0D5DD);

  @override
  Widget build(BuildContext context) {
    final bool isActive = showLabel;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isActive ? _activeBorderColor : _inactiveBorderColor,
              width: 1.5,
            ),
            color: Colors.white,
          ),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            style: GoogleFonts.openSans(),
            decoration: InputDecoration(
              hintText: 'Задача',
              hintStyle: GoogleFonts.openSans(
                color: Colors.grey[400],
                fontSize: 15,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
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
                'Задача',
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
}

