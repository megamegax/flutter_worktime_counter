import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:worktime_flutter/redux/action/Actions.dart';
import 'package:worktime_flutter/redux/model/models.dart';

final daysReducer = combineReducers<Map<String, Day>>([
  new TypedReducer<Map<String, Day>, AddDayEventAction>(add),
  new TypedReducer<Map<String, Day>, DayEventsLoadedAction>(loadDays)
]);
final dateFormatter = new DateFormat('yyyy-MM-dd');

Map<String, Day> add(Map<String, Day> days, AddDayEventAction action) {
  String key = dateFormatter.format(action.dayEvent.dateTime);
  days
    ..putIfAbsent(
        key, () => new Day(dateTime: action.dayEvent.dateTime, entries: []));

  days[key].entries.add(action.dayEvent);
  return days;
}

Map<String, Day> loadDays(Map<String, Day> days, DayEventsLoadedAction action) {
  action.dayEvents.forEach((dayEvent) {
    String key = dateFormatter.format(dayEvent.dateTime);
    days
      ..putIfAbsent(
          key, () => new Day(dateTime: dayEvent.dateTime, entries: []));

    days[key].entries.add(dayEvent);
  });
  return days;
}
