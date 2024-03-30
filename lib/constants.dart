// import 'dart:io';

// import 'package:path_provider/path_provider.dart';

// String todoPath = '';
// String donePath = '';

// String error = '';

// void getPaths() async {
//   try {
//     var directory;
//     // = await getApplicationDocumentsDirectory();
//     if (Platform.isAndroid) {
//       directory = Directory('/storage/emulated/0/Documents');
//     } else if (Platform.isLinux) {
//       directory = await getApplicationDocumentsDirectory();
//       // print(directory.path);
//     }
//     // else {}
//     // print(directory.path);

//     todoPath = '${directory.path}/todo.txt';
//     donePath = '${directory.path}/done.txt';
//   } catch (e) {
//     error = e.toString();
//     throw error;
//   }
// }
