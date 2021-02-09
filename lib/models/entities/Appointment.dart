import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Pacient.dart';

class Appointment {
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final DateFormat hourFormatter = DateFormat('HH:mm');

  Pacient pacient;
  DateTime monthDay;
  static List<Appointment> appnsList = new List();



  Appointment({this.monthDay});

  String getDateFormatted(DateTime monthDay) {
    return formatter.format(monthDay);
  }

  String getHourFormatted(DateTime timeOfDay) {
    return hourFormatter.format(timeOfDay);
  }

  void setMonthDay(DateTime monthDay) {
    this.monthDay = monthDay;
  }

  void setPacient(Pacient pacient) {
    this.pacient = pacient;
  }

  static List<Appointment> getAppointments() {
    return appnsList;
  }

  static void addApointment(Appointment appointment) {
    appnsList.add(appointment);
  }

  @override
  String toString() {
    return 'Appointment: Day: ${formatter.format(monthDay)}, time: ${hourFormatter.format(monthDay)}';
  }
}