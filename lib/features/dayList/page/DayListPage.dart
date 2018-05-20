import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:worktime_flutter/features/dayList/view/DayListScreen.dart';
import 'package:worktime_flutter/redux/model/models.dart';

class DayListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          return new DayListScreen(days: vm.store.state.days.values.toList());
        });
  }
}

class _ViewModel {
  final Store<AppState> store;

  _ViewModel({@required this.store});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(store: store);
  }
}
