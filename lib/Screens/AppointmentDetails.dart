import 'package:appointment/Screens/MyHomePage.dart';
import 'package:appointment/models/entities/Appointment.dart';
import 'package:flutter/material.dart';

import 'NewAppointment.dart';

class AppointmentDetails extends StatefulWidget{
  AppointmentDetails({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _AppointmentDetailsState createState() => _AppointmentDetailsState();

}

class _AppointmentDetailsState extends State<AppointmentDetails>{



  List<Appointment> appnDate = Appointment.appnsList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Appointments for "+MyHomePageState.getDate())),
      body: Container(
        child: Stack(
          children: <Widget> [
            ListView.builder(
              itemCount: Appointment.appnsList.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text('${Appointment.appnsList[index].getHourFormatted(Appointment.appnsList[index].monthDay)}'),
                  leading: Icon(
                      Icons.assignment
                  ),
                  subtitle: Text(appnDate[index].pacient == null || appnDate[index].pacient.name == "" ? "No patient Added yet" : appnDate[index].pacient.name),
                  trailing: Icon(
                      Icons.arrow_right
                  ),
                );
              },
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
