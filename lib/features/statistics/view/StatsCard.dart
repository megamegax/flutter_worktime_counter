import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  String dailyWorkTime;
  String monthlyWorkTime;
  String averageWorkTime;

  StatsCard({this.dailyWorkTime, this.monthlyWorkTime, this.averageWorkTime});

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Table(
        children: [
          new TableRow(children: [Text('Napi munkaidő'), Text(dailyWorkTime)]),
          new TableRow(
              children: [Text('Ebben a hónapban'), Text(monthlyWorkTime)]),
          new TableRow(children: [
            Container(
              height: 100.0,
            ),
            Container()
          ]),
          new TableRow(
              children: [Text('Átlagos munkaidő'), Text(averageWorkTime)]),
        ],
      ),
    );
  }
}
