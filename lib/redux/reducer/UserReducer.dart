import 'package:firebase_auth/firebase_auth.dart';
import 'package:redux/redux.dart';
import 'package:worktime_flutter/redux/action/Actions.dart';

final userReducer = combineReducers<FirebaseUser>(
    [new TypedReducer<FirebaseUser, UserLoggedInAction>(userLoggedIn)]);

FirebaseUser userLoggedIn(FirebaseUser oldUser, UserLoggedInAction action) {
  return action.user;
}
