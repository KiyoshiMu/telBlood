class TimeSeriesPoint {
  final DateTime time;
  final double value;
  final String uid = '1';
  TimeSeriesPoint({this.time, this.value});

  factory TimeSeriesPoint.fromDoc(doc) => TimeSeriesPoint(
    time : doc['time'], value: doc['values']
  );
} 