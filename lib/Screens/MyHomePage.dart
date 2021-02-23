import 'package:appointment/Screens/AppointmentDetails.dart';
import 'package:appointment/Screens/NewAppointment.dart';
import 'package:appointment/Screens/NewPacient.dart';
import 'package:appointment/db/Controller.dart';
import 'package:appointment/models/entities/Appointment.dart';
import 'package:appointment/utils/CircularButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'AllPacients.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

  CalendarController _controller;
  AnimationController _animationController;
  Animation degOneTranslationAnimation, degTwoTranslationAnimation, degThreeTranslationAnimation;
  Animation rotationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List _selectedEvents;

  static DateFormat dateFormatter = new DateFormat("dd-MM-yyyy");

  static DateTime selectedDate;

  static DateTime getDate(){
    return selectedDate;
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    setState(() {
      selectedDate = _controller.selectedDay;
      if (DBController().getAppointments() == null ) {
        events.add(Navigator.push(context,
            MaterialPageRoute(builder: (context) => NewAppointment())));
      } else {
        events.add(Navigator.push(context,
            MaterialPageRoute(builder: (context) => AppointmentDetails())));
      }
      _selectedEvents = events;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(_animationController);
    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(_animationController);
    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(_animationController);

    rotationAnimation = Tween<double>(begin: 180.0, end:0.0).animate(CurvedAnimation(parent: _animationController,
     curve: Curves.easeOut));
    _animationController.addListener(() {
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TableCalendar(
                startingDayOfWeek: StartingDayOfWeek.monday,
                onDaySelected: _onDaySelected,
                calendarController: _controller,
              ),
              Container(
                  child: Expanded(
                      child: Stack(
                children: <Widget>[
                  Positioned(
                      right: 30,
                      bottom: 30,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          IgnorePointer(
                            child: Container(
                              color: Colors.transparent,
                              height: 150.0,
                              width: 150.0,
                            ),
                          ),
                          Transform.translate(
                            offset: Offset.fromDirection(getRadiansFromDegree(180),degOneTranslationAnimation.value * 100),
                            child: Transform(
                              transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value))..scale(degOneTranslationAnimation.value),
                              alignment: Alignment.center,
                              child: CircularButton(
                                width: 45,
                                height: 45,
                                icon: Icon(Icons.add),
                                color: Colors.purple,
                                onClick: () {
                                  setState(() {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => NewAppointment()));
                                  });
                                },
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset.fromDirection(getRadiansFromDegree(225),degTwoTranslationAnimation.value *  100),
                            child: Transform(
                              transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value))..scale(degOneTranslationAnimation.value),
                              alignment: Alignment.center,
                              child: CircularButton(
                                width: 45,
                                height: 45,
                                icon: Icon(Icons.person),
                                color: Colors.blueAccent,
                                onClick: () {
                                  setState(() {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => NewPacient()));
                                  });
                                },
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset.fromDirection(getRadiansFromDegree(270),degThreeTranslationAnimation.value *  100),
                            child: Transform(
                              transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value))..scale(degOneTranslationAnimation.value),
                              alignment: Alignment.center,
                              child: CircularButton(
                                width: 45,
                                height: 45,
                                icon: Icon(Icons.label_important),
                                color: Colors.blueAccent,
                                onClick: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AllPacients()));
                                },
                              ),
                            ),
                          ),
                          Transform(
                            transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value)),
                            alignment: Alignment.center,
                            child: CircularButton(
                              width: 60,
                              height: 60,
                              icon: Icon(Icons.menu),
                              color: Colors.blue,
                              onClick: () {
                                if(_animationController.isCompleted) {
                                  _animationController.reverse();
                                } else {
                                  _animationController.forward();
                                }
                              },
                            ),
                          )
                        ],
                      ))
                ],
              )
                  )
              )
            ]
        )
    );
  }
}
