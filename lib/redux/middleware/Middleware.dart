import 'dart:async';

import 'package:intl/intl.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:worktime_flutter/redux/action/Actions.dart';
import 'package:worktime_flutter/redux/model/models.dart';

export 'ApiMiddleware.dart';
export 'QuoteMiddleware.dart';
export 'SignInMiddleware.dart';

final dateFormatter = new DateFormat('yyyy-MM-dd');

Stream<dynamic> getStats(Stream<dynamic> actions, EpicStore<AppState> store) {
  return new Stream.value(actions)
      .where((event) => event is DayEventsLoadedAction)
      .asyncMap((action) {
    return new GetStatsAction();
  });
}

Stream<dynamic> getDailyWorkTime(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return new Stream.value(actions)
      .where((event) => event is GetStatsAction)
      .asyncMap((action) => new CalculateDailyWorkTimeAction(
          day: store.state.days[dateFormatter.format(new DateTime.now())]));
}

Stream<dynamic> getAverageWorkTime(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return new Stream.value(actions)
      .where((event) => event is GetStatsAction)
      .asyncMap((action) => new CalculateAverageWorkTimeAction(
          days: store.state.days.values.toList()));
}

Stream<dynamic> addDayEventRefreshStats(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return new Stream.value(actions)
      .where((event) => event is AddDayEventAction)
      .asyncMap((action) => new GetStatsAction());
}

Stream<dynamic> refreshOnDayEventLoaded(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return new Stream.value(actions)
      .where((event) => event is DayEventsLoadedAction)
      .asyncMap((action) => new GetStatsAction());
}
