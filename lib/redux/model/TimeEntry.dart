import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:worktime_flutter/redux/model/Event.dart';

class DayEvent {
  var dateFormatter = new DateFormat('yyyy-MM-dd');
  var timeFormatter = new DateFormat('HH:mm:ss');

  Event event;
  String description;
  DateTime dateTime;
  DateTime timeOfDay;

  DayEvent({this.event, this.description, this.dateTime, this.timeOfDay});

  factory DayEvent.fromFireStore(DocumentSnapshot response) {
    var dateFormatter = new DateFormat('yyyy-MM-dd');
    var timeFormatter = new DateFormat('HH:mm:ss');
    final data = response.data() as Map<String, dynamic>;
    return new DayEvent(
        event: Event.values.firstWhere((e) => e.toString() == data['event']),
        description: data["description"],
        dateTime: dateFormatter.parse(data['dateTime']),
        timeOfDay: timeFormatter.parse(data['timeOfDay']));
  }

  toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map.putIfAbsent('event', () => event.toString());
    map.putIfAbsent('description', () => description ?? '');
    map.putIfAbsent('dateTime', () => dateFormatter.format(dateTime));
    map.putIfAbsent('timeOfDay', () => timeFormatter.format(timeOfDay));
    return map;
  }
}
