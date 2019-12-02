import 'dart:math';
import 'dart:async';
import 'package:telblood/models/sensor.dart';

class NumberCreator {

  DateTime _start = DateTime.now();
  final _rng = Random();
  final _controller = StreamController<TimeSeriesPoint>();

  NumberCreator (double mean) {
    Timer.periodic(Duration(seconds: 1), (t) {
      _controller.sink.add(TimeSeriesPoint(time: _start, value: mean));
      mean += (_rng.nextDouble() - 0.5) * 10;
      _start = _start.add(Duration(seconds: 1));
    });
  }
  Stream<TimeSeriesPoint> get stream => _controller.stream;
}