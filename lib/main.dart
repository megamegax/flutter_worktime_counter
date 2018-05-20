import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:worktime_flutter/features/addEditEvent/page/AddTimePage.dart';
import 'package:worktime_flutter/presentation/HomePage.dart';
import 'package:worktime_flutter/redux/action/Actions.dart';
import 'package:worktime_flutter/redux/middleware/Middleware.dart';
import 'package:worktime_flutter/redux/model/models.dart';
import 'package:worktime_flutter/redux/reducer/AppStateReducer.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  Store<AppState> store;

  MyApp() {
    final allEpics = combineEpics<AppState>([
      loadDaysFromFirestore,
      saveDaysToFirestore,
      refreshOnDayEventLoaded,
      getStats,
      getDailyWorkTime,
      getAverageWorkTime,
      addDayEventRefreshStats,
      signIn,
      loadDailyQuote,
    ]);
    store = Store<AppState>(appReducer,
        initialState: AppState(
            days: new Map<String, Day>(),
            addEditPageState:
                new AddEditPageState(dateTime: new DateTime.now()),
            statisticPageState: new StatisticPageState(
                dailyWorkTime: '-',
                monthlyWorkTime: '-',
                averageWorkTime: '-',
                quote: new Quote(quote: '-', author: '-'),
                isLoading: true)),
        middleware: [new EpicMiddleware(allEpics)]);
  }

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new MaterialApp(
        title: 'Worktime Manager',
        routes: {
          Routes.home: (context) {
            return new StoreBuilder<AppState>(
              onInit: (store) {
                store.dispatch(new LoginAction());
                store.dispatch(new GetDailyQuoteAction());
              },
              builder: (context, store) {
                return new HomePage();
              },
            );
          },
          Routes.addTime: (context) {
            return new AddTimePage();
          },
        },
      ),
    );
  }
}

class Routes {
  static final home = "/";
  static final addTime = "/addTime";
}
