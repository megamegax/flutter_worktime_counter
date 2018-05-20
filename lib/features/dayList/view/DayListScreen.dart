import 'package:flutter/material.dart';
import 'package:worktime_flutter/redux/model/models.dart';
import 'package:worktime_flutter/features/dayList/view/TimeEntryCardItem.dart';

class DayListScreen extends StatelessWidget {
  List<Day> days;

  DayListScreen({this.days});

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: new ListView(
          children: days?.map((day) {
                return new TimeEntryCardItem(day: day);
              })?.toList() ??
              []),
    );
  }
}
