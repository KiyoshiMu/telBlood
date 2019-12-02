import 'dart:async';
import 'package:telblood/services/telbloodDB_api.dart';
import 'package:telblood/services/authentication_api.dart';
import 'package:telblood/models/sensor.dart';

class HomeBloc {
  final DBApi dbApi;
  final AuthenticationApi authenticationApi;
  final _pointsController = StreamController<List<TimeSeriesPoint>>.broadcast();
  Sink<List<TimeSeriesPoint>> get _addListPoint => _pointsController.sink;
  void _startListeners() {

    authenticationApi.getFirebaseAuth().currentUser().then((user)
    {
    dbApi.getPointsList(user.uid).listen((journalDocs) {
      _addListPoint.add(journalDocs);
      });
    });
  }

  HomeBloc(this.dbApi, this.authenticationApi) {
    _startListeners();
  }
}