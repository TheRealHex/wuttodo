// import 'package:flutter/material.dart';

// import '../data/textdata.dart';
// import '../style.dart';

// Widget buildTodoItem(BuildContext context, TextData data, Widget btns) {
//   final ThemeData theme = Theme.of(context);
//   void _showDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Center(
//           child: AlertDialog(
//             backgroundColor: theme.colorScheme.secondaryContainer,
//             title: Container(
//               padding: EdgeInsets.all(5),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(6),
//                 color: theme.colorScheme.primary,
//               ),
//               child: Center(
//                 child: Text(
//                   calculateTimePassed(data.time).toString(),
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: theme.colorScheme.onSurface,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             content: Container(
//               padding: EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               constraints: BoxConstraints(
//                   maxWidth: MediaQuery.sizeOf(context).width / 1.6),
//               child: Text(
//                 data.value,
//                 style: contentTextStyle(context),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
//     child: Container(
//       decoration: BoxDecoration(
//         color: theme.colorScheme.primaryContainer,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Flexible(
//             child: ListTile(
//               onTap: _showDialog,
//               title: Text(
//                 data.value,
//                 maxLines: 1,
//               ),
//               titleTextStyle: contentTextStyle(context),
//             ),
//           ),
//           btns
//         ],
//       ),
//     ),
//   );
// }

// String calculateTimePassed(DateTime date) {
//   final currentDate = DateTime.now();
//   final difference = currentDate.difference(date);

//   final days = difference.inDays;
//   final hours = difference.inHours % 24;
//   final minutes = difference.inMinutes % 60;

//   String result = '';
//   if (days > 0) result += '$days days';
//   if (hours > 0) {
//     if (result.isNotEmpty) result += ', ';
//     result += '$hours hrs';
//   }
//   if (minutes >= 0) {
//     if (result.isNotEmpty) result += ', ';
//     result += '$minutes mins';
//   }
//   if (result.isNotEmpty) result += ' ago';
//   return result;
// }
