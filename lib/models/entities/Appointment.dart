import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Pacient.dart';

class Appointment {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final DateFormat hourFormatter = DateFormat('HH:mm:ss');
  final DateFormat toStringFormat = DateFormat('dd-MM-yyyy');


  int id;
  int pacientId;
  DateTime monthDay;

  Appointment({this.monthDay, this.pacientId});

  String getDateFormatted(DateTime monthDay) {
    return formatter.format(monthDay);
  }

  String getHourFormatted(DateTime timeOfDay) {
    return hourFormatter.format(timeOfDay);
  }

  void setMonthDay(DateTime monthDay) {
    this.monthDay = monthDay;
  }

  void setPacient(int pacientId) {
    this.pacientId = pacientId;
  }

  @override
  String toString() {
    return 'Appointment: Day: ${toStringFormat.format(monthDay)}, id:$pacientId, time: ${hourFormatter.format(monthDay)}';
  }

  Map<String, dynamic> toMap() {
    return {
      'date':formatter.format(monthDay),
      'hour':hourFormatter.format(monthDay),

    };
  }
}