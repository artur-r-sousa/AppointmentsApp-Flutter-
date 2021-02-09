import 'package:flutter/material.dart';

class NewPacient extends StatefulWidget {
  NewPacient({Key key, this.title}) : super(key: key);
  final String title;
  @override
  State<StatefulWidget> createState() => NewPacientState();

}

class NewPacientState extends State<NewPacient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add new patients"),),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Form(
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Patient Name",
                      hintText: "Patient Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Form(
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Patient email",
                      hintText: "Patient email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Form(
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Patient description",
                      hintText: "Patient description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}