import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:worktime_flutter/redux/action/Actions.dart';
import 'package:worktime_flutter/redux/model/models.dart';

Stream<dynamic> loadDailyQuote(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return new Observable(actions)
      .ofType(new TypeToken<GetDailyQuoteAction>())
      .asyncMap((action) => fetchDailyQuote()
          .then((quote) => new DailyQuoteLoadedAction(quote: quote))
          .catchError((error) => new DailyQuoteLoadedAction(
              quote: new Quote(title: error.toString(), author: "developer"))));
}

Future<Quote> fetchDailyQuote() async {
  final response = await http.get('http://quotes.rest/qod.json');
  final responseJson = json.decode(response.body);
  return new Quote.fromJson(responseJson);
}
