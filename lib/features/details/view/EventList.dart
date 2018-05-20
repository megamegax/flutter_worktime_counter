import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:worktime_flutter/common/util/EventMapper.dart';
import 'package:worktime_flutter/redux/model/models.dart';

class EventList extends StatelessWidget {
  Day day;
  var dateFormatter = new DateFormat('yyyy-MM-dd');
  var timeFormatter = new DateFormat('HH:mm:ss');

  EventList({this.day});

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Card(
        child: new ListView(
            children: day.entries.map((entry) {
          return new InkWell(
            onTap: () {},
            child: new ListTile(
              title: new Text('${mapEventToString(entry.event)}'),
              trailing: new Text('${dateFormatter
                      .format(entry.dateTime)} ${timeFormatter.format(
                      entry.timeOfDay)}'),
            ),
          );
        }).toList()),
      ),
    );
  }
}
