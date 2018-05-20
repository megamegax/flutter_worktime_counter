import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:worktime_flutter/features/details/view/EventList.dart';
import 'package:worktime_flutter/redux/model/models.dart';

class DayDetailsPage extends StatelessWidget {
  Day day;
  var dateFormatter = new DateFormat('yyyy-MM-dd');
  var timeFormatter = new DateFormat('HH:mm:ss');

  DayDetailsPage({this.day});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Day')),
      body: new Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            gradient: new LinearGradient(
                colors: [Colors.lightBlueAccent, Colors.blueAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: new Column(children: [
          new Hero(
            tag: 'card_${day.dateTime.toString()}',
            child: new Card(
              child: new Padding(
                padding: const EdgeInsets.all(16.0),
                child: new SingleChildScrollView(
                  child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              new Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Row(children: [
                                  new Hero(
                                      tag: 'date_${day.dateTime.toString()}',
                                      child: new Text(
                                        dateFormatter.format(day.dateTime),
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                  new Expanded(
                                    child: new Container(),
                                  ),
                                  new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: new Text('Benttöltött idő'),
                                      ),
                                      new Hero(
                                        tag: 'daily_hours_${day.dateTime
                                            .toString()}',
                                        child: new Text(
                                          day.inTime(),
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                            ]),
                        new Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              new Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text('Munkanap'),
                              ),
                              new Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(day.workDay(),
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ),
                              new Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text('Ebédszünet'),
                              ),
                              new Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text('12:00:00 - 12:30:00',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ),
                            ]),
                      ]),
                ),
              ),
            ),
          ),
          new EventList(day: day)
        ]),
      ),
    );
  }
}
