import 'package:intl/intl.dart';
import 'package:worktime_flutter/redux/model/models.dart';

class Day {
  DateTime dateTime;
  List<DayEvent> entries;
  var timeFormatter = new DateFormat('HH:mm:ss');

  Day({this.dateTime, this.entries});

  bool isHoliday() {
    return entries.any((entry) => entry.event == Event.SZABI);
  }

  String workDay() {
    DayEvent beginOfDay = entries.firstWhere((entry) => entry.event == Event.BE,
        orElse: () => new DayEvent(timeOfDay: DateTime.now()));
    DayEvent endOfDay = entries.lastWhere((entry) => entry.event == Event.KI,
        orElse: () => new DayEvent(timeOfDay: DateTime.now()));

    return '${timeFormatter.format(beginOfDay.timeOfDay)} - ${timeFormatter
        .format(endOfDay.timeOfDay)}';
  }

  String mealTime() {
    DayEvent beginOfMeal = entries.firstWhere(
        (entry) => entry.event == Event.EBED,
        orElse: () => new DayEvent(timeOfDay: DateTime(2018, 1, 1, 12, 0)));
    DayEvent endOfMeal = entries.lastWhere(
        (entry) => entry.event == Event.EBED_VEGE,
        orElse: () => new DayEvent(timeOfDay: DateTime(2018, 1, 1, 12, 30)));

    return '${timeFormatter.format(beginOfMeal.timeOfDay)} - ${timeFormatter
        .format(endOfMeal.timeOfDay)}';
  }

  String inTime() {
    DayEvent beginOfDay = entries.firstWhere((entry) => entry.event == Event.BE,
        orElse: () => new DayEvent(timeOfDay: DateTime.now()));
    DayEvent endOfDay = entries.lastWhere((entry) => entry.event == Event.KI,
        orElse: () => new DayEvent(timeOfDay: DateTime.now()));

    Duration workDiff = new Duration(
            hours: endOfDay.timeOfDay.hour,
            minutes: endOfDay.timeOfDay.minute,
            seconds: endOfDay.timeOfDay.second) -
        Duration(
            hours: beginOfDay.timeOfDay.hour,
            minutes: beginOfDay.timeOfDay.minute,
            seconds: beginOfDay.timeOfDay.second);
    DayEvent beginOfMeal = entries.firstWhere(
        (entry) => entry.event == Event.EBED,
        orElse: () => new DayEvent(timeOfDay: DateTime(2018, 1, 1, 12, 0)));
    DayEvent endOfMeal = entries.lastWhere(
        (entry) => entry.event == Event.EBED_VEGE,
        orElse: () => new DayEvent(timeOfDay: DateTime(2018, 1, 1, 12, 30)));
    Duration mealDiff = new Duration(
            hours: endOfMeal.timeOfDay.hour,
            minutes: endOfMeal.timeOfDay.minute,
            seconds: endOfMeal.timeOfDay.second) -
        new Duration(
            hours: beginOfMeal.timeOfDay.hour,
            minutes: beginOfMeal.timeOfDay.minute,
            seconds: beginOfMeal.timeOfDay.second);

    Duration nettoWorkTime = workDiff - mealDiff;
    return timeFormatter.format(DateTime(0).add(nettoWorkTime));
  }
}
