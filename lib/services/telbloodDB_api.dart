import 'package:telblood/models/sensor.dart';

abstract class DBApi {
  Future<bool> addMinData(List<TimeSeriesPoint> points);
  Stream<List<TimeSeriesPoint>> getPointsList(String uid);
}
