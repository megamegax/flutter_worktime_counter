import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:worktime_flutter/features/addEditEvent/view/AddEditTimeScreen.dart';
import 'package:worktime_flutter/redux/action/Actions.dart';
import 'package:worktime_flutter/redux/model/models.dart';

class AddTimePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        vm.setContext(context);
        return new AddEditTimeScreen(
          isEditing: true,
          state: vm.store.state.addEditPageState,
          onEventChanged: (event) {
            vm.onEventChanged(event);
          },
          onDateTimeChanged: (dateTime) {
            if (dateTime != null) {
              vm.onDateTimeChanged(dateTime);
            }
          },
          onDescriptionChanged: (description) {
            vm.onDescriptionChanged(description);
          },
          onSave: (dayEvent) {
            vm.onSave(dayEvent);
          },
        );
      },
    );
  }
}

class _ViewModel {
  final Store<AppState> store;
  BuildContext context;

  _ViewModel({@required this.store});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(store: store);
  }

  setContext(BuildContext context) {
    this.context = context;
  }

  onEventChanged(Event event) {
    store.dispatch(new SelectEventAction(event: event));
  }

  onDateTimeChanged(DateTime dateTime) {
    store.dispatch(new SelectDateTimeAction(dateTime: dateTime));
  }

  onDescriptionChanged(String description) {
    store.dispatch(new ChangeDescriptionAction(description: description));
  }

  onSave(DayEvent dayEvent) {
    store.dispatch(new AddDayEventAction(dayEvent: dayEvent));
    Navigator.pop(context);
  }
}
