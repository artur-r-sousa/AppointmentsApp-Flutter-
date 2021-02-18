import 'package:appointment/Screens/MyHomePage.dart';
import 'package:appointment/db/Controller.dart';
import 'package:appointment/models/entities/Appointment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'NewAppointment.dart';

class AppointmentDetails extends StatefulWidget{
  AppointmentDetails({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _AppointmentDetailsState createState() => _AppointmentDetailsState();

}

class _AppointmentDetailsState extends State<AppointmentDetails>{
  DateFormat queryDateFormatter = DateFormat('yyyy-MM-dd');
  DateFormat titleFormatter = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Appointments for "+titleFormatter.format(MyHomePageState.getDate()))),
      body: Container(
        child: Stack(
          children: <Widget> [
            FutureBuilder<List>(
              future: DBController().getAppointmentsFromDay(queryDateFormatter.format(MyHomePageState.getDate())),
              builder: (context, snapshot) {
                return snapshot.hasData ? ListView.builder(
                  itemCount: snapshot.data.length,
                    itemBuilder: (_, int position) {
                    final item = snapshot.data[position];
                    return Card(
                      child: ListTile(
                        title: Text(
                          snapshot.data[position].toString()),
                        ),

                    );
                    }
                ) : Center(child: CircularProgressIndicator());
              }
            )
            ,Container(
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NewAppointment()));
                    });
                  }),
                  Padding(padding: EdgeInsets.only(left: 20), child: Text("New Appointment"))
                ],
              ),
            )
          ]
        ),
      ),
    );
  }
}


