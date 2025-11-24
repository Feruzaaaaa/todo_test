import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/task_model.dart';

class TaskItemContent extends StatelessWidget {
  final Task task;
  final bool isCompact;

  // ➜ Добавили параметр для размера текста
  final double? titleFontSize;

  const TaskItemContent({
    Key? key,
    required this.task,
    this.isCompact = false,
    this.titleFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 5 : 20,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: isCompact
            ? null
            : Border(
          top: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Row(
        children: [
          _buildBookmarkIcon(),
          SizedBox(width: isCompact ? 20 : 12),
          Expanded(
            child: _buildTaskInfo(),
          ),
        ],
      ),
    );
  }

  Widget _buildBookmarkIcon() {
    return Image.asset(
      'lib/assets/icons/bookmark.png',
      width: isCompact ? 5 : 20,
      height: isCompact ? 5 : 20,
    );
  }

  Widget _buildTaskInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          task.title,
          maxLines: isCompact ? 1 : null,
          overflow: isCompact ? TextOverflow.ellipsis : null,

          // ➜ Размер текста теперь такой же как у категорий (управляется снаружи)
          style: GoogleFonts.plusJakartaSans(
            fontSize: titleFontSize ?? 15,   // если не передали — старый 15
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        _buildDateInfo(),
      ],
    );
  }

  Widget _buildDateInfo() {
    return Row(
      children: [
        Icon(
          Icons.access_time,
          size: 14,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 4),
        Text(
          DateFormat('dd MMMM', 'ru').format(task.date),
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

