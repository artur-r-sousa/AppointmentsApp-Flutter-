import 'package:appointment/Screens/NewPacient.dart';
import 'package:appointment/db/Controller.dart';
import 'package:appointment/models/entities/Pacient.dart';
import 'package:flutter/material.dart';

class AllPacients extends StatefulWidget{
  AllPacients({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _AllPacientsState createState() => _AllPacientsState();
}

class _AllPacientsState extends State<AllPacients>{

  Pacient pacientHolder = new Pacient();

  setPacientHolder(Pacient pacient) {
    pacientHolder = pacient;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registered patients")),
      body: Container(
        child: Stack(
            children: <Widget> [
              FutureBuilder<List>(
                  future: DBController().pacients(),
                  builder: (context, snapshot) {
                    return snapshot.hasData ? ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, int position) {
                          return Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                      snapshot.data[position].toString()),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    TextButton(onPressed: () async {
                                      final item = snapshot.data[position];
                                      setPacientHolder(item);
                                      DBController().deletePacient(pacientHolder.id);
                                      setState(() {});
                                    }, child: Text('Delete'))
                                  ],
                                )
                              ],
                            )
                          );
                        }
                    ) : Center(child: CircularProgressIndicator());
                  }
              ),
              Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.bottomRight,
                child: Row(
                  children: [
                    FloatingActionButton(
                        child: Icon(
                            Icons.add
                        ),
                        onPressed: (){
                          setState(() {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => NewPacient()));
                          });
                        }),
                    Padding(padding: EdgeInsets.only(left: 20), child: Text("New Patient"))
                  ],
                ),
              )
            ]
        ),
      ),
    );
  }
}
