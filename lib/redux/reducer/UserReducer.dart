import 'package:firebase_auth/firebase_auth.dart';
import 'package:redux/redux.dart';
import 'package:worktime_flutter/redux/action/Actions.dart';

final userReducer = combineReducers<User>(
    [new TypedReducer<User, UserLoggedInAction>(userLoggedIn)]);

User userLoggedIn(User oldUser, UserLoggedInAction action) {
  return action.user;
}
