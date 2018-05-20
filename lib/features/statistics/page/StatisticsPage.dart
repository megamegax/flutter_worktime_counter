import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:worktime_flutter/features/statistics/view/StatisticsScreen.dart';
import 'package:worktime_flutter/redux/model/models.dart';

class StatisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          return new StatisticsScreen(
            dailyWorkTime: vm.dailyWorkTime(),
            monthlyWorkTime: vm.monthlyWorkTime(),
            averageWorkTime: vm.averageWorkTime(),
            quote: vm.quote(),
            isLoading: vm.isLoading(),
          );
        });
  }
}

class _ViewModel {
  final Store<AppState> store;

  _ViewModel({@required this.store});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(store: store);
  }

  String dailyWorkTime() {
    return store.state.statisticPageState.dailyWorkTime;
  }

  String monthlyWorkTime() {
    return store.state.statisticPageState.monthlyWorkTime;
  }

  String averageWorkTime() {
    return store.state.statisticPageState.averageWorkTime;
  }

  Quote quote() {
    return store.state.statisticPageState.quote;
  }

  bool isLoading() {
    return store.state.statisticPageState.isLoading;
  }
}
