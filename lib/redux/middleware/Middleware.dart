import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:worktime_flutter/redux/action/Actions.dart';
import 'package:worktime_flutter/redux/model/models.dart';

export 'QuoteMiddleware.dart';
export 'SignInMiddleware.dart';

final dateFormatter = new DateFormat('yyyy-MM-dd');

Stream<dynamic> getStats(Stream<dynamic> actions, EpicStore<AppState> store) {
  return new Observable(actions)
      .ofType(new TypeToken<DayEventsLoadedAction>())
      .asyncMap((action) {
    return new GetStatsAction();
  });
}

Stream<dynamic> getDailyWorkTime(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return new Observable(actions)
      .ofType(new TypeToken<GetStatsAction>())
      .asyncMap((action) => new CalculateDailyWorkTimeAction(
          day: store.state.days[dateFormatter.format(new DateTime.now())]));
}

Stream<dynamic> getAverageWorkTime(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return new Observable(actions)
      .ofType(new TypeToken<GetStatsAction>())
      .asyncMap((action) => new CalculateAverageWorkTimeAction(
          days: store.state.days.values.toList()));
}

Stream<dynamic> addDayEventRefreshStats(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return new Observable(actions)
      .ofType(new TypeToken<AddDayEventAction>())
      .asyncMap((action) => new GetStatsAction());
}

Stream<dynamic> loadDaysFromFirestore(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return new Observable(actions)
      .ofType(new TypeToken<UserLoggedInAction>())
      .asyncMap((action) => fetchDayEvents(store).then((dayEvents) {
            print('dayEvent.then: $dayEvents');
            return new DayEventsLoadedAction(dayEvents: dayEvents);
          }).catchError((error) {
            print('error: $error');
            return new DayEventsLoadedAction(dayEvents: new List<DayEvent>());
          }))
      .map((event) {
    print('event: $event');
    return event;
  });
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

Stream<dynamic> refreshOnDayEventLoaded(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return new Observable(actions)
      .ofType(new TypeToken<DayEventsLoadedAction>())
      .asyncMap((action) => new GetStatsAction());
}
