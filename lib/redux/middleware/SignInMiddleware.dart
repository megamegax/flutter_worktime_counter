import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:worktime_flutter/redux/AppState.dart';
import 'package:worktime_flutter/redux/action/Actions.dart';

Stream<dynamic> signIn(Stream<dynamic> actions, EpicStore<AppState> store) {
  return new Observable(actions).ofType(new TypeToken<LoginAction>()).asyncMap(
      (action) => _handleSignIn()
          .then((user) => new UserLoggedInAction(user: user))
          .catchError((error) => new ErrorAction(message: error.toString())));
}

Future<FirebaseUser> _handleSignIn() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  FirebaseUser user = await _auth.signInWithGoogle(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  return user;
}
