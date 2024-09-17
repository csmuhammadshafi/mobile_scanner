import 'package:flutter/material.dart';

import 'HomePage.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and open a box to store documents
  final directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);
  await Hive.openBox('documentsBox'); // Open a box to store documents

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  HomeScreen(),
    );
  }
}

