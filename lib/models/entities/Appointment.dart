import 'package:intl/intl.dart';

class Appointment {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final DateFormat hourFormatter = DateFormat('HH:mm:ss');
  final DateFormat toStringFormat = DateFormat('dd-MM-yyyy');

  int id;
  int pacientId;
  DateTime monthDay;

  Appointment({
    this.id,
    this.monthDay,
    this.pacientId
  });

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
  String toString(){
    return '${hourFormatter.format(monthDay)}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Appointment &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'date':formatter.format(monthDay),
      'hour':hourFormatter.format(monthDay),
      'pacientId':pacientId,
    };
  }
}