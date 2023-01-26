import 'package:flutter/material.dart';

import '../model/list_item.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatelessWidget {
  static const String idScreen = "calendarScreen";
  final List<ListItem> _ispiti;

  CalendarScreen(this._ispiti);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("My calendar"),
      ),
      body: Container(
        child: SfCalendar(
          view: CalendarView.month,
          dataSource: MeetingDataSource(_getDataSource(_ispiti)),
          monthViewSettings: MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
          firstDayOfWeek: 1,
          showDatePickerButton: true,
        ),
      ),
    );
  }
}

List<ListItem> _getDataSource(List<ListItem> _ispiti) {
  final List<ListItem> zakazhaniIspiti = _ispiti;
  return zakazhaniIspiti;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<ListItem> source) {
    appointments = source;
  }

  @override
  String getSubject(int index) {
    return appointments![index].ime;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].datum;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].datum;
  }
}
