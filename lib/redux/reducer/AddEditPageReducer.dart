import 'package:redux/redux.dart';
import 'package:worktime_flutter/common/util/EventMapper.dart';
import 'package:worktime_flutter/redux/action/Actions.dart';
import 'package:worktime_flutter/redux/model/models.dart';

final addEditPageReducer = combineReducers<AddEditPageState>([
  new TypedReducer<AddEditPageState, SelectEventAction>(_selectEvent),
  new TypedReducer<AddEditPageState, SelectDateTimeAction>(_selectDateTime)
]);

AddEditPageState _selectEvent(
    AddEditPageState state, SelectEventAction action) {
  return state.copyWith(selectedEvent: mapEventToString(action.event));
}

AddEditPageState _selectDateTime(
    AddEditPageState state, SelectDateTimeAction action) {
  return state.copyWith(dateTime: action.dateTime);
}
