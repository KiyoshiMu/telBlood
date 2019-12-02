import 'dart:async';
import 'package:telblood/services/authentication_api.dart';

class AuthenticationBloc {
  final AuthenticationApi authenticationApi;
  final _authenController = StreamController<String>();
  Sink<String> get addUser => _authenController.sink;
  Stream<String> get user => _authenController.stream;

  final _logoutController = StreamController<bool>();
  Sink<bool> get logoutUser => _logoutController.sink;
  Stream<bool> get listLogoutUser => _logoutController.stream;

  AuthenticationBloc(this.authenticationApi) {
    onAuthChanged();
  }

  void dispose() {
    _authenController.close();
    _logoutController.close();
  }

  void _signOut(){
    authenticationApi.signOut();
  }

  void onAuthChanged() {
    authenticationApi.getFirebaseAuth()
      .onAuthStateChanged
      .listen((user) {
        final String uid = user != null ? user.uid : null;
        addUser.add(uid);
      });
    _logoutController.stream.listen((logout) {
      if (logout == true) {
        _signOut();
      }
    });
  }
}