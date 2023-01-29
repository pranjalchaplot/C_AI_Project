import 'package:flutter/material.dart';
import './pages/home_page.dart';

void main() {
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online Scheduler',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}


//Sources: https://protocoderspoint.com/read-json-file-assets-flutter-display-data-listview
//Sources: https://stackoverflow.com/questions/51807228/writing-to-a-local-json-file-dart-flutter