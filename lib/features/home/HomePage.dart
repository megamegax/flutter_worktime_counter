import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:worktime_flutter/features/dayList/page/DayListPage.dart';
import 'package:worktime_flutter/features/statistics/page/StatisticsPage.dart';
import 'package:worktime_flutter/main.dart';
import 'package:worktime_flutter/redux/model/models.dart';
import 'package:worktime_flutter/redux/action/Actions.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        appBar: new AppBar(
          bottom: new TabBar(
            tabs: [
              new Tab(icon: new Icon(Icons.timeline)),
              new Tab(icon: new Icon(Icons.dehaze)),
            ],
          ),
          title: new Text('Worktime Manager'),
        ),
        body: new Container(
          decoration: BoxDecoration(
              gradient: new LinearGradient(
                  colors: [Colors.lightBlueAccent, Colors.blueAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: new TabBarView(
            children: [
              new StatisticsPage(),
              new DayListPage(),
            ],
          ),
        ),
        floatingActionButton: new Hero(
          tag: 'floating_action_button',
          child: new FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () {
              Navigator.pushNamed(context, Routes.addTime);
            },
            child: new Icon(Icons.add),
            tooltip: "Add Time",
          ),
        ),
      ),
    );
  }
}
