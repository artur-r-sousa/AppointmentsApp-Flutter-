import 'package:appointment/db/Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Screens/MyHomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DBController().getDB();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Welcome',), debugShowCheckedModeBanner: false, //MyHomePage(title: 'Welcome') //UpdatePacient(title: 't')
    );
  }
}





