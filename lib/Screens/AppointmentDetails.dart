import 'package:appointment/Screens/MyHomePage.dart';
import 'package:appointment/db/Controller.dart';
import 'package:appointment/models/entities/Appointment.dart';
import 'package:appointment/models/entities/Pacient.dart';
import 'package:appointment/Screens/UpdatePacient.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'NewAppointment.dart';

class AppointmentDetails extends StatefulWidget{
  AppointmentDetails({Key key, this.title}) : super(key: key);
  final String title;
  @override
  AppointmentDetailsState createState() => AppointmentDetailsState();

}

class AppointmentDetailsState extends State<AppointmentDetails>{
  DateFormat queryDateFormatter = DateFormat('yyyy-MM-dd');
  DateFormat titleFormatter = DateFormat('dd-MM-yyyy');

  Future<String> pacientName(int id) async {
    List<Pacient> name = await DBController().getPacients(id);
    return name[0].name;
  }

  static Pacient pacientHolder = new Pacient();

  Future<void> getPacient(Appointment appointment) async {
    Pacient foo = await DBController().getPacientFromAppointment(appointment);
    pacientHolder = foo;
  }


  static Appointment appointmentHolder = new Appointment();

  static Appointment getAppointmentHolder() {
    return appointmentHolder;
  }

  static void setAppn(Appointment appointment) {
    appointmentHolder = appointment;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () {

                                setAppn(item);
                                print(appointmentHolder);
                                getPacient(item);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePacient()));
                              },
                              title: Text(
                                  snapshot.data[position].toString()),
                            ),
                            FutureBuilder(
                                future: DBController().getPacientFromAppointment(snapshot.data[position]),
                                builder: (context, snapshot2){
                                  return snapshot2.hasData ? ListTile(
                                    onTap: () {
                                      print(snapshot.data[position].toString());
                                      print(snapshot2.data.toString());

                                    },
                                    title: Text(snapshot2.data.toString())
                                  ) : Center(child: CircularProgressIndicator());
                                })
                          ],
                        )
                      );
                    }
                ) : Center(child: CircularProgressIndicator());
              }
            ),Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                  child: Icon(
                      Icons.add
                  ),
                  onPressed: (){
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NewAppointment()));
                    });
                  }),
            )
          ]
        ),
      ),
    );
  }
}


