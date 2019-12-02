import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telblood/models/fixedqueue.dart';
import 'package:telblood/models/sensor.dart';
import 'package:telblood/utils/creator.dart';
import 'package:flutter/foundation.dart';
import 'package:telblood/services/auth.dart';

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
  final recorder = Recorder(50, 125.0);
  final title = 'Blood Glucose';
  final unit = 'mg/dL';
}

class BpConfig {
  final recorder = Recorder(50, 125.0);
  final title = 'Blood Pressure';
  final unit = 'mmHg';
}

class Sensors with ChangeNotifier {
  UserRepository user;
  Sensors({UserRepository user}) {
    if (user != null && user.status == Status.Authenticated) {
      final _gluRef = Firestore.instance.collection(gluConfig.title);
      final _bpRef = Firestore.instance.collection(bpConfig.title);
      Timer.periodic(Duration(seconds: 10),
          (t) => writeRecode(_gluRef, gluConfig.recorder, user.user.email));
      Timer.periodic(Duration(seconds: 10),
          (t) => writeRecode(_bpRef, bpConfig.recorder, user.user.email));
    }
  }
  final _gluConfig = GluConfig();
  final _bpConfig = BpConfig();
  GluConfig get gluConfig => _gluConfig;
  BpConfig get bpConfig => _bpConfig;
}

void writeRecode(CollectionReference ref, Recorder recorder, String uid) {
  final previous = recorder.previous.toList();
  final time = previous[previous.length ~/ 2].time;
  final value =
      previous.map((p) => p.value).reduce((a, b) => a + b) / previous.length;
  ref.document().setData({
    'time': time.toUtc(), 
    'value': value,
    'uid': uid,
  });
}
