import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:worktime_flutter/redux/action/Actions.dart';
import 'package:worktime_flutter/redux/model/models.dart';

Stream<dynamic> loadDaysFromFirestore(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return new Stream.value(actions)
      .where((event) => event is UserLoggedInAction)
      .asyncMap((action) => fetchDayEvents(store).then((dayEvents) {
            return new DayEventsLoadedAction(dayEvents: dayEvents);
          }).catchError((error) {
            print('error: $error');
            return new DayEventsLoadedAction(dayEvents: <DayEvent>[]);
          }));
}

Future<List<DayEvent>> fetchDayEvents(EpicStore<AppState> store) {
  return FirebaseFirestore.instance
      .collection('database')
      .doc(store.state.user.uid)
      .collection('days')
      .get()
      .then((response) => response.docs
          .map((document) => new DayEvent.fromFireStore(document))
          .toList());
}

Stream<dynamic> saveDaysToFirestore(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return new Stream.value(actions)
      .where((event) => event is AddDayEventAction)
      .asyncMap((action) {
    AddDayEventAction a = action as AddDayEventAction;
    FirebaseFirestore.instance
        .collection('database/${store.state.user.uid}/days')
        .add(a.dayEvent.toMap());
  });
}
