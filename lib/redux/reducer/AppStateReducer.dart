import 'package:worktime_flutter/redux/model/models.dart';
import 'package:worktime_flutter/redux/reducer/Reducers.dart';

AppState appReducer(AppState state, action) {
  return new AppState(
      days: daysReducer(state.days, action),
      addEditPageState: addEditPageReducer(state.addEditPageState, action),
      statisticPageState: statsReducer(state.statisticPageState, action),
      user: userReducer(state.user, action));
}
