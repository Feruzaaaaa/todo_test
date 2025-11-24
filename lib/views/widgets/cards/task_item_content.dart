import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../models/task_model.dart';

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
    final bool isOverdue = _isOverdue(task.date);
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 12 : 20,
        vertical: isCompact ? 10 : 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isCompact
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIconsColumn(),
          SizedBox(width: isCompact ? 8 : 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTaskTitle(),
                const SizedBox(height: 8),
                _buildDateInfo(isOverdue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _isOverdue(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final taskDate = DateTime(date.year, date.month, date.day);
    return taskDate.isBefore(today);
  }

  Widget _buildIconsColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildBookmarkIcon(),
        const SizedBox(height: 10),
        _buildCalendarIcon(),
      ],
    );
  }

  Widget _buildBookmarkIcon() {
    return Image.asset(
      'assets/icons/bookmark.png',
      width: isCompact ? 18 : 26,
      height: isCompact ? 18 : 26,
    );
  }

  Widget _buildCalendarIcon() {
    return Image.asset(
      'assets/icons/calendar.png',
      width: 16,
      height: 16,
      color: Colors.grey[600],
    );
  }

  Widget _buildTaskTitle() {
    return Text(
      task.title,
      maxLines: isCompact ? 1 : null,
      overflow: isCompact ? TextOverflow.ellipsis : null,
      style: GoogleFonts.plusJakartaSans(
        fontSize: titleFontSize ?? 15,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildDateInfo(bool isOverdue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          DateFormat('dd MMMM', 'ru').format(task.date),
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
        if (isOverdue) _buildOverdueBadge(),
      ],
    );
  }

  Widget _buildOverdueBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFF5A5A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Просрочена',
        style: GoogleFonts.plusJakartaSans(
          fontSize: 11,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

