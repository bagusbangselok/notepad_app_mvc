import 'package:flutter/material.dart';
import 'package:notepad_app/controller/notepad_controller.dart';
import 'package:notepad_app/controller/status_controller.dart';
import 'package:notepad_app/controller/theme_controller.dart';
import 'package:notepad_app/data/database/notepad_database.dart';
import 'package:notepad_app/data/model/status_model.dart';
import 'package:notepad_app/view/main_notepad.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await insertSampleStatus();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context, listen: true);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NotePad',
      theme: themeController.theme,
      home: const MainNotepad(),
    );
  }
}



// Future<void> insertSampleStatus() async {
//   StatusController statusController = StatusController();
//   final status1 = StatusModel(
//       status: 'In-progress',
//       createdAt: DateTime.now()
//   );
//   final status2 = StatusModel(
//     status: 'Completed',
//     createdAt: DateTime.now()
//   );
//
//   await statusController.createStatus(status1);
//   // Insert second status
//   await statusController.createStatus(status2);
// }
