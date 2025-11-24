import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/todo_screen.dart';
import 'models/task_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация Hive
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');

  // Инициализация русской локали для дат
  await initializeDateFormatting('ru', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(),
      ),
      home: const TodoScreen(),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await initializeDateFormatting('ru', null);
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         textTheme: GoogleFonts.openSansTextTheme(),
//       ),
//       home: const TodoScreen(),
//     );
//   }
// }
//
// class Task {
//   String title;
//   DateTime date;
//   String status;
//
//   Task({required this.title, required this.date, required this.status});
// }
//
// class TodoScreen extends StatefulWidget {
//   const TodoScreen({Key? key}) : super(key: key);
//
//   @override
//   State<TodoScreen> createState() => _TodoScreenState();
// }
//
// class _TodoScreenState extends State<TodoScreen> {
//   List<Task> tasks = [];
//   Map<String, bool> expandedSections = {
//     'К выполнению': false,
//     'В работе': false,
//     'На проверке': false,
//     'Выполнено': false,
//   };
//
//   void _showCreateTaskDialog() {
//     final TextEditingController taskController = TextEditingController();
//     DateTime? selectedDate;
//
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (context, setDialogState) {
//             return Container(
//               padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom,
//               ),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Создание задачи',
//                           style: GoogleFonts.openSans(
//                             fontSize: 18,
//                             color: Colors.black,
//                           ),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.close, size: 22),
//                           onPressed: () => Navigator.pop(context),
//                           padding: EdgeInsets.zero,
//                           constraints: const BoxConstraints(),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     TextField(
//                       controller: taskController,
//                       style: GoogleFonts.openSans(),
//                       decoration: InputDecoration(
//                         hintText: 'Задача',
//                         hintStyle: GoogleFonts.openSans(
//                           color: Colors.grey[400],
//                           fontSize: 15,
//                         ),
//                         filled: true,
//                         fillColor: const Color(0xFFF5F5F5),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide.none,
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide.none,
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide.none,
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 14,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     InkWell(
//                       onTap: () async {
//                         final DateTime? picked = await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime.now(),
//                           lastDate: DateTime(2100),
//                           builder: (context, child) {
//                             return Theme(
//                               data: Theme.of(context).copyWith(
//                                 colorScheme: const ColorScheme.light(
//                                   primary: Color(0xFF007D88),
//                                 ),
//                               ),
//                               child: child!,
//                             );
//                           },
//                         );
//                         if (picked != null) {
//                           setDialogState(() {
//                             selectedDate = picked;
//                           });
//                         }
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 14,
//                         ),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFF5F5F5),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               selectedDate == null
//                                   ? 'Выберите'
//                                   : DateFormat('dd.MM.yyyy').format(selectedDate!),
//                               style: GoogleFonts.openSans(
//                                 color: selectedDate == null
//                                     ? Colors.grey[400]
//                                     : Colors.black,
//                                 fontSize: 15,
//                               ),
//                             ),
//                             Icon(Icons.calendar_today_outlined,
//                                 size: 20, color: Colors.grey[600]),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: TextButton(
//                             onPressed: () => Navigator.pop(context),
//                             style: TextButton.styleFrom(
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                               backgroundColor: const Color(0xFFE0E0E0),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             child: Text(
//                               'Отменить',
//                               style: GoogleFonts.plusJakartaSans(
//                                 color: Colors.black87,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: TextButton(
//                             onPressed: () {
//                               if (taskController.text.isNotEmpty &&
//                                   selectedDate != null) {
//                                 setState(() {
//                                   tasks.add(Task(
//                                     title: taskController.text,
//                                     date: selectedDate!,
//                                     status: 'К выполнению',
//                                   ));
//                                 });
//                                 Navigator.pop(context);
//                               }
//                             },
//                             style: TextButton.styleFrom(
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                               backgroundColor: const Color(0xFF007D88),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             child: Text(
//                               'Применить',
//                               style: GoogleFonts.plusJakartaSans(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   List<Task> getTasksByStatus(String status) {
//     return tasks.where((task) => task.status == status).toList();
//   }
//
//   void changeTaskStatus(Task task, String newStatus) {
//     setState(() {
//       task.status = newStatus;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF9FAFA),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Todo',
//                     style: GoogleFonts.plusJakartaSans(
//                       fontSize: 30,
//                       // fontWeight: FontWeight.bold,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black,
//                     ),
//                   ),
//                   Container(
//                     width: 60,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF007D88),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: IconButton(
//                       icon: const Icon(
//                         Icons.add,
//                         color: Colors.white,
//                         size: 32,
//                       ),
//                       onPressed: _showCreateTaskDialog,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 32),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       DragTarget<Task>(
//                         onAcceptWithDetails: (details) {
//                           changeTaskStatus(details.data, 'К выполнению');
//                         },
//                         builder: (context, candidateData, rejectedData) {
//                           return TodoStatusCard(
//                             title: 'К выполнению',
//                             count: getTasksByStatus('К выполнению').length,
//                             isExpanded: expandedSections['К выполнению']!,
//                             onTap: () {
//                               setState(() {
//                                 expandedSections['К выполнению'] =
//                                 !expandedSections['К выполнению']!;
//                               });
//                             },
//                             tasks: getTasksByStatus('К выполнению'),
//                             onStatusChange: changeTaskStatus,
//                             isHighlighted: candidateData.isNotEmpty,
//                           );
//                         },
//                       ),
//                       const SizedBox(height: 12),
//                       DragTarget<Task>(
//                         onAcceptWithDetails: (details) {
//                           changeTaskStatus(details.data, 'В работе');
//                         },
//                         builder: (context, candidateData, rejectedData) {
//                           return TodoStatusCard(
//                             title: 'В работе',
//                             count: getTasksByStatus('В работе').length,
//                             isExpanded: expandedSections['В работе']!,
//                             onTap: () {
//                               setState(() {
//                                 expandedSections['В работе'] =
//                                 !expandedSections['В работе']!;
//                               });
//                             },
//                             tasks: getTasksByStatus('В работе'),
//                             onStatusChange: changeTaskStatus,
//                             isHighlighted: candidateData.isNotEmpty,
//                           );
//                         },
//                       ),
//                       const SizedBox(height: 12),
//                       DragTarget<Task>(
//                         onAcceptWithDetails: (details) {
//                           changeTaskStatus(details.data, 'На проверке');
//                         },
//                         builder: (context, candidateData, rejectedData) {
//                           return TodoStatusCard(
//                             title: 'На проверке',
//                             count: getTasksByStatus('На проверке').length,
//                             isExpanded: expandedSections['На проверке']!,
//                             onTap: () {
//                               setState(() {
//                                 expandedSections['На проверке'] =
//                                 !expandedSections['На проверке']!;
//                               });
//                             },
//                             tasks: getTasksByStatus('На проверке'),
//                             onStatusChange: changeTaskStatus,
//                             isHighlighted: candidateData.isNotEmpty,
//                           );
//                         },
//                       ),
//                       const SizedBox(height: 12),
//                       DragTarget<Task>(
//                         onAcceptWithDetails: (details) {
//                           changeTaskStatus(details.data, 'Выполнено');
//                         },
//                         builder: (context, candidateData, rejectedData) {
//                           return TodoStatusCard(
//                             title: 'Выполнено',
//                             count: getTasksByStatus('Выполнено').length,
//                             isExpanded: expandedSections['Выполнено']!,
//                             onTap: () {
//                               setState(() {
//                                 expandedSections['Выполнено'] =
//                                 !expandedSections['Выполнено']!;
//                               });
//                             },
//                             tasks: getTasksByStatus('Выполнено'),
//                             onStatusChange: changeTaskStatus,
//                             isHighlighted: candidateData.isNotEmpty,
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class TodoStatusCard extends StatelessWidget {
//   final String title;
//   final int count;
//   final bool isExpanded;
//   final VoidCallback onTap;
//   final List<Task> tasks;
//   final Function(Task, String) onStatusChange;
//   final bool isHighlighted;
//
//   const TodoStatusCard({
//     Key? key,
//     required this.title,
//     required this.count,
//     required this.isExpanded,
//     required this.onTap,
//     required this.tasks,
//     required this.onStatusChange,
//     this.isHighlighted = false,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 200),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: isHighlighted
//             ? Border.all(color: const Color(0xFF007D88), width: 2)
//             : null,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           InkWell(
//             onTap: onTap,
//             borderRadius: BorderRadius.circular(12),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     title,
//                     style: GoogleFonts.plusJakartaSans(
//                       fontSize: 18,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         count.toString(),
//                         style: GoogleFonts.plusJakartaSans(
//                           fontSize: 18,
//                           color: Colors.black,
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Icon(
//                         isExpanded
//                             ? Icons.keyboard_arrow_up
//                             : Icons.keyboard_arrow_down,
//                         color: Colors.black,
//                         size: 24,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (isExpanded)
//             Column(
//               children: tasks.map((task) {
//                 return DraggableTaskItem(
//                   task: task,
//                   onStatusChange: onStatusChange,
//                 );
//               }).toList(),
//             ),
//         ],
//       ),
//     );
//   }
// }
//
// class DraggableTaskItem extends StatelessWidget {
//   final Task task;
//   final Function(Task, String) onStatusChange;
//
//   const DraggableTaskItem({
//     Key? key,
//     required this.task,
//     required this.onStatusChange,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final double feedbackWidth = constraints.maxWidth - 20;
//
//         return LongPressDraggable<Task>(
//           data: task,
//           feedback: Material(
//             elevation: 8,
//             borderRadius: BorderRadius.circular(8),
//             child: SizedBox(
//               width: feedbackWidth,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 10,
//                       offset: Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     Image.asset(
//                       'lib/assets/icons/bookmark.png',
//                       width: 5,
//                       height: 5,
//                     ),
//                     const SizedBox(width: 20),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             task.title,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: GoogleFonts.plusJakartaSans(
//                               fontSize: 15,
//                               color: Colors.black,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Row(
//                             children: [
//                               Icon(Icons.access_time,
//                                   size: 14, color: Colors.grey[600]),
//                               const SizedBox(width: 4),
//                               Text(
//                                 DateFormat('dd MMMM', 'ru').format(task.date),
//                                 style: GoogleFonts.plusJakartaSans(
//                                   fontSize: 13,
//                                   color: Colors.grey[600],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           childWhenDragging: Opacity(
//             opacity: 0.3,
//             child: TaskItemContent(task: task),
//           ),
//           child: TaskItemContent(task: task),
//         );
//       },
//     );
//   }
// }
//
// class TaskItemContent extends StatelessWidget {
//   final Task task;
//
//   const TaskItemContent({
//     Key? key,
//     required this.task,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border(
//           top: BorderSide(color: Colors.grey[200]!),
//         ),
//       ),
//       child: Row(
//         children: [
//           Image.asset(
//             'lib/assets/icons/bookmark.png',
//             width: 20,
//             height: 20,
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   task.title,
//                   style: GoogleFonts.plusJakartaSans(
//                     fontSize: 15,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
//                     const SizedBox(width: 4),
//                     Text(
//                       DateFormat('dd MMMM', 'ru').format(task.date),
//                       style: GoogleFonts.plusJakartaSans(
//                         fontSize: 13,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }