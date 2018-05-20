import 'package:intl/intl.dart';
import 'package:worktime_flutter/redux/model/models.dart';

class Statistic {
  List<Day> days;
  var timeFormatter = new DateFormat('HH:mm:ss');

  Statistic({this.days});

  String dailyWorkTime() {
    if (days.length > 0) {
      return days.last.inTime();
    } else
      return '00:00:00';
  }

  String avgWorkTime() {
    if (days.length > 0) {
      final daysSumInMillis = days.map((day) => day.inTime()).map((inTime) {
        DateTime time = timeFormatter.parse(inTime);
        return Duration(
                hours: time.hour, minutes: time.minute, seconds: time.second)
            .inMilliseconds;
      }).reduce((a, b) => a + b);
      final averageInMillis = daysSumInMillis / days.length;
      final averageWorkTimeInMonth =
          new Duration(milliseconds: averageInMillis.round());
      return timeFormatter.format(new DateTime(0).add(averageWorkTimeInMonth));
    } else {
      return '00:00:00';
    }
  }
}
