import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import 'model/models.dart';

@immutable
class AppState {
  final FirebaseUser user;
  final Map<String, Day> days;
  final AddEditPageState addEditPageState;
  final StatisticPageState statisticPageState;

  AppState(
      {this.days, this.addEditPageState, this.statisticPageState, this.user});

  AppState copyWith(
      {List<Day> days,
      AddEditPageState addEditPageState,
      StatisticPageState statisticPageState,
      FirebaseUser user}) {
    return AppState(
        days: days ?? this.days,
        addEditPageState: addEditPageState ?? this.addEditPageState,
        statisticPageState: statisticPageState ?? this.statisticPageState,
        user: user ?? this.user);
  }
}

@immutable
class StatisticPageState {
  final String dailyWorkTime;
  final String monthlyWorkTime;
  final String averageWorkTime;
  final Quote quote;
  final bool isLoading;

  StatisticPageState(
      {this.dailyWorkTime,
      this.monthlyWorkTime,
      this.averageWorkTime,
      this.quote,
      this.isLoading});

  StatisticPageState copyWith(
      {String dailyWorkTime,
      String monthlyWorkTime,
      String averageWorkTime,
      Quote quote,
      bool isLoading}) {
    return new StatisticPageState(
        dailyWorkTime: dailyWorkTime ?? this.dailyWorkTime,
        monthlyWorkTime: monthlyWorkTime ?? this.monthlyWorkTime,
        averageWorkTime: averageWorkTime ?? this.averageWorkTime,
        quote: quote ?? this.quote,
        isLoading: isLoading ?? this.isLoading);
  }
}

@immutable
class AddEditPageState {
  final String actualDate;
  final String selectedEvent;
  final String description;
  final DateTime dateTime;

  AddEditPageState(
      {this.actualDate, this.selectedEvent, this.description, this.dateTime});

  AddEditPageState copyWith(
      {String actualDate,
      String selectedEvent,
      String description,
      DateTime dateTime}) {
    return AddEditPageState(
        actualDate: actualDate ?? this.actualDate,
        selectedEvent: selectedEvent ?? this.selectedEvent,
        description: description ?? this.description,
        dateTime: dateTime ?? this.dateTime);
  }
}
