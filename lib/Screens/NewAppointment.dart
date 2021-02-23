import 'package:appointment/Screens/AppointmentDetails.dart';
import 'package:appointment/Screens/MyHomePage.dart';
import 'package:appointment/db/Controller.dart';
import 'package:appointment/models/entities/Appointment.dart';
import 'package:appointment/models/entities/Pacient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class NewAppointment extends StatefulWidget {
  NewAppointment({Key key, this.title}) : super(key: key);
  final String title;
  @override
  State<StatefulWidget> createState() => NewAppointmentState();
}

class NewAppointmentState extends State<NewAppointment> {

  TextEditingController hourController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController extraController = new TextEditingController();

  final DateFormat formatter = DateFormat('yyyy-MM-dd');


  @override
  void initState(){
    super.initState();
    hourController.addListener(changeFormat);
  }

  var maskFormatter = new MaskTextInputFormatter(mask: '&!:*@', filter: {"&": RegExp(r'[0-2]'), "!": RegExp(r'[0-9]'), "*": RegExp(r'[0-5]'),"@": RegExp(r'[0-9]')});
  var phoneNumberMask = new MaskTextInputFormatter(mask: '## #####-####', filter: {"#": RegExp(r'[0-9]') });

  void changeFormat() {
    if(hourController.text == "2") {
      maskFormatter.updateMask(mask: '&!:*@', filter: {"&": RegExp(r'[0-2]'), "!": RegExp(r'[0-3]'), "*": RegExp(r'[0-5]'),"@": RegExp(r'[0-9]')});
    } else {
      maskFormatter.updateMask(mask: '&!:*@', filter: {"&": RegExp(r'[0-2]'), "!": RegExp(r'[0-9]'), "*": RegExp(r'[0-5]'),"@": RegExp(r'[0-9]')});
    }
  }

  MaskTextInputFormatter inputFormat() {
    return maskFormatter;
  }

  //reminder to send this method to the utils class
  Future<void> _showMyDialog(String title, String dialogText) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(dialogText),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Back'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("New Appointments")),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Form(
                child: TextFormField(
                  controller: nameController,
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
                  controller: emailController,
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
            ),
            Container(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Form(
                child: TextFormField(
                  controller: hourController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [inputFormat()],
                  decoration: InputDecoration(

                      labelText: "Appointment Hour",
                      hintText: "00:00",

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
                  controller: phoneNumberController,
                  inputFormatters: [phoneNumberMask],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Patient phone number",
                      hintText: "Patient phone number",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  FloatingActionButton(
                      heroTag: null,
                      child: Icon(
                        Icons.add,
                      ),
                      onPressed: () async {
                        if (nameController.text == "" || nameController.text == "Patient Name") {
                          _showMyDialog("Empty Fields", "Name field can't be empty");
                        } else if(phoneNumberController.text == "" || phoneNumberController.text == "Phone Number") {
                          _showMyDialog("Empty Fields", "Phone field can't be empty");
                        } else {
                          Appointment appNew = new Appointment();
                          Pacient newPacient = new Pacient();
                          newPacient.setName(nameController.text);
                          newPacient.setEmail(emailController.text);
                          newPacient.setPhoneNumber(phoneNumberController.text);
                          newPacient.setExtra(extraController.text);
                          //send patient to db. when you retrieve the patient the result is a list<pacient>, so put it in
                          // a list and access the first(and only since phone number is a unique identification) result, then get its id
                          setState(()  {
                            DBController().insertPatient(newPacient);
                          });
                          List<Pacient> gettingPatient = await DBController().getPacientsByPN(phoneNumberController.text);
                          print(phoneNumberController.text);
                          print(gettingPatient);

                          setState(() {
                              appNew.setPacient(gettingPatient[0].id);
                              hourController.text != "" ? appNew.setMonthDay(DateTime.parse("${formatter.format(MyHomePageState.selectedDate)} " + "${hourController.text}")) : appNew.setMonthDay(DateTime.now());
                              DBController().insertAppointment(appNew);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppointmentDetails()));
                            });

                        }
                      }
                  ),
                  Padding(padding: EdgeInsets.only(left: 15), child: Text("New Appointment")),
                ],
              )
            ),
            Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  FloatingActionButton(
                      heroTag: null,
                      child: Icon(
                          Icons.arrow_back
                      ),
                      onPressed: (){ setState(() {

                        Navigator.pop(context);
                      });}),
                  Padding(padding: EdgeInsets.only(left: 15), child: Text("Go Back")),
                ],
              )
            ),
            Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [
                    FloatingActionButton(
                        heroTag: null,
                        child: Icon(
                            Icons.arrow_back
                        ),
                        onPressed: (){ setState(() {
                          DBController().deleteAllPacients();

                          Navigator.pop(context);
                        });}),
                    Padding(padding: EdgeInsets.only(left: 15), child: Text("Delete all patients")),
                  ],
                )
            ),
            Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [
                    FloatingActionButton(
                        heroTag: null,
                        child: Icon(
                            Icons.arrow_back
                        ),
                        onPressed: (){ setState(() {
                          DBController().deleteAllAppointments();
                          Navigator.pop(context);
                        });}),
                    Padding(padding: EdgeInsets.only(left: 15), child: Text("Delete all appointments")),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}