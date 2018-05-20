import 'package:flutter/material.dart';
import 'package:worktime_flutter/redux/model/Event.dart';

class EventItem extends StatelessWidget {
  String title;
  Event event;

  EventItem({this.title, this.event});

  @override
  Widget build(BuildContext context) {
    return new Text(title);
  }
}
