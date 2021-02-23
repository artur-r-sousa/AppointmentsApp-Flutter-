import 'dart:async';

import 'package:appointment/Screens/AppointmentDetails.dart';
import 'package:appointment/Screens/MyHomePage.dart';
import 'package:appointment/db/Controller.dart';
import 'package:appointment/models/entities/Appointment.dart';
import 'package:appointment/models/entities/Pacient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class UpdatePacient extends StatefulWidget {
  UpdatePacient({Key key, this.title}) : super(key: key);
  final String title;
  @override
  State<StatefulWidget> createState() => UpdatePacientState();
}

class UpdatePacientState extends State<UpdatePacient> {

  TextEditingController hourController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController extraController = new TextEditingController();

  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  DateFormat queryDateFormatter = DateFormat('yyyy-MM-dd');
  DateFormat titleFormatter = DateFormat('dd-MM-yyyy');
  DateFormat hourFormatter = DateFormat('HH:mm:ss');

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

  Appointment appointmentHolder2 = new Appointment();


  Future<void> getAppointment(int id) async {
    List<Appointment> appnList = await DBController().getAppointment(id);
    appointmentHolder2 = appnList[0];
  }


  //reminder to send this method to the utils class
  Future<void> _showMyDialog(String title, String dialogText) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
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

  showConfirmationDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Confirm"),
      onPressed: () {
        DBController().deleteAppointment(AppointmentDetailsState.appointmentHolder.id);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppointmentDetails()));
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Would you like to delete appointment?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Update appointments")),
      body: Container(
        child: Column(
          children: [
            FutureBuilder(
                future: DBController().getAppn(AppointmentDetailsState.appointmentHolder.id),
                builder: (context, snapshot) {
                  return snapshot.hasData ? Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: Form(
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                  labelText: AppointmentDetailsState.pacientHolder.name,
                                  hintText: AppointmentDetailsState.pacientHolder.name,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)
                                  )
                              ),
                            ),
                          ),
                        ),Container(
                          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: Form(
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  labelText: AppointmentDetailsState.pacientHolder.email,
                                  hintText:  AppointmentDetailsState.pacientHolder.email,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)
                                  )
                              ),
                            ),
                          ),
                        ),Container(
                          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: Form(
                            child: TextFormField(
                              controller: phoneNumberController,
                              decoration: InputDecoration(
                                  labelText: AppointmentDetailsState.pacientHolder.phoneNumber,
                                  hintText: AppointmentDetailsState.pacientHolder.phoneNumber,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)
                                  )
                              ),
                            ),
                          ),
                        ),Container(
                          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: Form(
                            child: TextFormField(
                              controller: extraController,
                              decoration: InputDecoration(
                                  labelText: AppointmentDetailsState.pacientHolder.extra,
                                  hintText: AppointmentDetailsState.pacientHolder.extra,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)
                                  )
                              ),
                            ),
                          ),
                        ),Container(
                          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: Form(
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                  labelText: hourFormatter.format(AppointmentDetailsState.appointmentHolder.monthDay),
                                  hintText:  hourFormatter.format(AppointmentDetailsState.appointmentHolder.monthDay),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)
                                  )
                              ),
                            ),
                          ),
                        ),Container(
                          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: Form(
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                  labelText: titleFormatter.format(AppointmentDetailsState.appointmentHolder.monthDay),
                                  hintText:  titleFormatter.format(AppointmentDetailsState.appointmentHolder.monthDay),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)
                                  )
                              ),
                            ),
                          ),
                        ),Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(width: 15.0, height: 5.0,),
                              FloatingActionButton(heroTag: null, child: Icon(Icons.update, size: 40,), onPressed: (){
                                
                              }, ),
                              SizedBox(width: 15.0, height: 5.0,),
                              FloatingActionButton(heroTag: null, child: Icon(Icons.delete, size: 35),
                                onPressed: () {
                                  showConfirmationDialog(context);
                                })
                            ],
                          ),
                        )


                      ],
                    )
                  ) : Center(child: CircularProgressIndicator(),);

                }
            )
          ],
        ),
      ),
    );
  }
}