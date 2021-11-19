import 'package:flutter/material.dart';
import 'package:worktime_flutter/redux/model/Event.dart';
import 'package:worktime_flutter/redux/model/models.dart';
import 'package:worktime_flutter/common/util/EventMapper.dart';
import 'package:worktime_flutter/features/addEditEvent/view/EventItem.dart';

class AddEditTimeScreen extends StatelessWidget {
  List<DropdownMenuItem> events = [];
  var isEditing = false;
  AddEditPageState state;
  Function(Event) onEventChanged;
  Function(DateTime) onDateTimeChanged;
  Function(String) onDescriptionChanged;
  Function(DayEvent) onSave;

  AddEditTimeScreen(
      {this.isEditing,
      this.state,
      this.onEventChanged,
      this.onDateTimeChanged,
      this.onDescriptionChanged,
      this.onSave}) {
    events.add(new DropdownMenuItem(
        value: 'Érkezés',
        child: new EventItem(title: 'Érkezés', event: Event.BE)));
    events.add(new DropdownMenuItem(
        value: 'Hazamenés',
        child: new EventItem(title: 'Hazamenés', event: Event.KI)));
    events.add(new DropdownMenuItem(
        value: 'Ebéd eleje',
        child: new EventItem(title: 'Ebéd eleje', event: Event.EBED)));
    events.add(new DropdownMenuItem(
        value: 'Ebéd vége',
        child: new EventItem(title: 'Ebéd vége', event: Event.EBED_VEGE)));
    events.add(new DropdownMenuItem(
        value: 'Szabadság',
        child: new EventItem(title: 'Szabadság', event: Event.SZABI)));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Add Day')),
      body: new Container(
        decoration: BoxDecoration(
            gradient: new LinearGradient(
                colors: [Colors.lightBlueAccent, Colors.blueAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: new Center(
          child: new Hero(
            tag: 'main_card',
            child: new Card(
              margin: EdgeInsets.all(8.0),
              child: new SingleChildScrollView(
                child: new Container(
                  width: double.infinity,
                  height: 200.0,
                  padding: const EdgeInsets.all(16.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Row(
                        children: [
                          new Text(state.dateTime.toString()),
                          new Expanded(child: new Container()),
                          new IconButton(
                              icon: new Icon(Icons.calendar_today),
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: new DateTime.now(),
                                        firstDate: new DateTime(2017),
                                        lastDate: new DateTime(2020))
                                    .then((date) {
                                  showTimePicker(
                                          context: context,
                                          initialTime: new TimeOfDay.now())
                                      .then((time) {
                                    if (date == null || time == null) {
                                      onDateTimeChanged(null);
                                    } else {
                                      onDateTimeChanged(new DateTime(
                                          date.year,
                                          date.month,
                                          date.day,
                                          time.hour,
                                          time.minute));
                                    }
                                  });
                                });
                              })
                        ],
                      ),
                      new DropdownButton(
                        value: state.selectedEvent,
                        items: events,
                        onChanged: (newEvent) {
                          onEventChanged(mapStringToEvent(newEvent));
                        },
                      ),
                      new TextField(
                        decoration: InputDecoration(labelText: 'Leírás'),
                        onSubmitted: onDescriptionChanged,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          final date = new DateTime(
              state.dateTime.year, state.dateTime.month, state.dateTime.day);
          onSave(new DayEvent(
              event: mapStringToEvent(state.selectedEvent),
              description: state.description,
              dateTime: date,
              timeOfDay: DateTime(0, 0, 0, state.dateTime.hour,
                  state.dateTime.minute, state.dateTime.second)));
        },
        child: new Icon(Icons.add),
      ),
    );
  }
}
