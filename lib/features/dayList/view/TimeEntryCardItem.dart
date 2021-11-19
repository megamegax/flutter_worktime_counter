import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:worktime_flutter/features/details/page/DayDetailsPage.dart';
import 'package:worktime_flutter/redux/model/models.dart';

class TimeEntryCardItem extends StatelessWidget {
  Day day;
  var dateFormatter = new DateFormat('yyyy-MM-dd');
  var timeFormatter = new DateFormat('HH:mm:ss');
  TimeEntryCardItem({this.day});

  @override
  Widget build(BuildContext context) {
    return new Hero(
      tag: 'card_${day.dateTime.toString()}',
      child: new Card(
          elevation: 2.0,
          child: new InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DayDetailsPage(day: day)));
            },
            child: new Padding(
              padding: const EdgeInsets.all(16.0),
              child: new Row(
                children: [
                  new Text(
                    dateFormatter.format(day.dateTime),
                    style: new TextStyle(fontWeight: FontWeight.bold),
                  ),
                  new Expanded(child: new Container()),
                  new Text(day.inTime()),
                ],
              ),
            ),
          )),
    );
  }
}
