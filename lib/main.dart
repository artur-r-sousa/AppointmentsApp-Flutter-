
import 'package:appointment/db/Controller.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'Screens/MyHomePage.dart';
import 'models/entities/Pacient.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DBController().getDB();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Welcome'), debugShowCheckedModeBanner: false,
    );
  }

}



