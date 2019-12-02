import 'package:flutter/material.dart';
import 'package:telblood/models/fixedqueue.dart';
import 'package:telblood/models/sensor.dart';
import 'package:telblood/utils/creator.dart';
import 'package:telblood/bloc/authentication_bloc.dart';

class Recorder {
  FixedQueue<TimeSeriesPoint> previous;
  Stream<TimeSeriesPoint> flowin;
   
  Recorder(int length, double mean) {
    this.previous = FixedQueue(length);
    this.flowin = NumberCreator(mean).stream.asBroadcastStream();
    flowin.listen((data) => previous.add(data));
  }
}

class GluConfig {
  final recorder = Recorder(50, 100.0);
  final title = 'Blood Glucose';
  final unit = 'mg/dL';
}

class BpConfig {
  final recorder = Recorder(50, 100.0);
  final title = 'Blood Pressure';
  final unit = 'mmHg';
}

class Configs extends InheritedWidget {
  final AuthenticationBloc authenticationBloc;
  Configs({Key key, Widget child, this.authenticationBloc}) : super(
    key: key, child:child);
  final gluConfig = GluConfig();
  final bpConfig = BpConfig();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Configs of (BuildContext context) => 
    context.dependOnInheritedWidgetOfExactType();
}