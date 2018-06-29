import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:worktime_flutter/redux/action/Actions.dart';
import 'package:worktime_flutter/redux/model/models.dart';

final timeFormatter = new DateFormat('HH:mm:ss');

final statsReducer = combineReducers<StatisticPageState>([
  new TypedReducer<StatisticPageState, CalculateDailyWorkTimeAction>(
      dailyWorkTime),
  new TypedReducer<StatisticPageState, CalculateAverageWorkTimeAction>(
      averageWorkTime),
  new TypedReducer<StatisticPageState, DailyQuoteLoadedAction>(loadQuote),
]);

StatisticPageState dailyWorkTime(
    StatisticPageState stats, CalculateDailyWorkTimeAction action) {
  String calculatedDailyWorkTime = '00:00:00';
  if (action.day != null) {
    calculatedDailyWorkTime = action.day.inTime();
  }
  return stats.copyWith(dailyWorkTime: calculatedDailyWorkTime);
}

StatisticPageState loadQuote(
    StatisticPageState stats, DailyQuoteLoadedAction action) {
  return stats.copyWith(isLoading: false, quote: action.quote);
}

StatisticPageState averageWorkTime(
    StatisticPageState stats, CalculateAverageWorkTimeAction action) {
  String calculatedAverageWorkTime = '00:00:00';
  int currentMonth = DateTime.now().month;
  if (action.days.length > 0) {
    final daysOfMonth =
        action.days.where((day) => day.dateTime.month == currentMonth);
    final daysSumInMillis =
        daysOfMonth.map((day) => day.inTime()).map((inTime) {
      DateTime time = timeFormatter.parse(inTime);
      return Duration(
              hours: time.hour, minutes: time.minute, seconds: time.second)
          .inMilliseconds;
    }).reduce((a, b) => a + b);
    final averageInMillis = daysSumInMillis / daysOfMonth.length;
    final averageWorkTimeInMonth =
        new Duration(milliseconds: averageInMillis.round());
    calculatedAverageWorkTime =
        timeFormatter.format(new DateTime(0).add(averageWorkTimeInMonth));
  }
  return stats.copyWith(averageWorkTime: calculatedAverageWorkTime);
}
