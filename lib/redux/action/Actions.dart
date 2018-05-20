import 'package:firebase_auth/firebase_auth.dart';
import 'package:worktime_flutter/redux/model/models.dart';

class GetStatsAction {}

class StatsLoadedAction {
  Statistic statistic;

  StatsLoadedAction({this.statistic});
}

class CalculateAverageWorkTimeAction {
  List<Day> days;

  CalculateAverageWorkTimeAction({this.days});
}

class CalculateDailyWorkTimeAction {
  Day day;

  CalculateDailyWorkTimeAction({this.day});
}

class LoginAction {}

class UserLoggedInAction {
  FirebaseUser user;

  UserLoggedInAction({this.user});
}

class GetDailyQuoteAction {}

class GetDaysHistoryAction {}

class DaysLoadedAction {
  List<Day> days;

  DaysLoadedAction({this.days});
}

class DayEventsLoadedAction {
  List<DayEvent> dayEvents;

  DayEventsLoadedAction({this.dayEvents});
}

class GetDayEventsAction {
  Day day;

  GetDayEventsAction({this.day});
}

class DailyQuoteLoadedAction {
  Quote quote;

  DailyQuoteLoadedAction({this.quote});
}

class SaveDailyQuoteAction {
  Quote quote;

  SaveDailyQuoteAction({this.quote});
}

class SelectEventAction {
  Event event;

  SelectEventAction({this.event});
}

class ChangeDescriptionAction {
  String description;

  ChangeDescriptionAction({this.description});
}

class SelectDateTimeAction {
  DateTime dateTime;

  SelectDateTimeAction({this.dateTime});
}

class AddDayEventAction {
  DayEvent dayEvent;

  AddDayEventAction({this.dayEvent});
}

class ErrorAction {
  String message;

  ErrorAction({this.message});
}
