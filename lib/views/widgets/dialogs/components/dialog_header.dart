import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateTaskDialogHeader extends StatelessWidget {
  final VoidCallback onClose;

  const CreateTaskDialogHeader({
    super.key,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
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
          onPressed: onClose,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}

