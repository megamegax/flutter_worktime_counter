import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:worktime_flutter/redux/action/Actions.dart';
import 'package:worktime_flutter/redux/model/models.dart';

Stream<dynamic> loadDaysFromFirestore(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return new Observable(actions)
      .ofType(new TypeToken<UserLoggedInAction>())
      .asyncMap((action) => fetchDayEvents(store).then((dayEvents) {
            return new DayEventsLoadedAction(dayEvents: dayEvents);
          }).catchError((error) {
            print('error: $error');
            return new DayEventsLoadedAction(dayEvents: new List<DayEvent>());
          }));
}

Future<List<DayEvent>> fetchDayEvents(EpicStore<AppState> store) {
  return Firestore.instance
      .collection('database')
      .document(store.state.user.uid)
      .collection('days')
      .getDocuments()
      .then((response) => response.documents
          .map((document) => new DayEvent.fromFireStore(document))
          .toList());
}

Stream<dynamic> saveDaysToFirestore(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return new Observable(actions)
      .ofType(new TypeToken<AddDayEventAction>())
      .asyncMap((action) {
    Firestore.instance
        .collection('database/${store.state.user.uid}/days')
        .add(action.dayEvent.toMap());
  });
}
