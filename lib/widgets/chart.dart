import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:telblood/models/sensor.dart';
import 'package:telblood/models/fixedqueue.dart';

class Chart extends StatelessWidget {
  
  final Stream stream;
  final FixedQueue<TimeSeriesPoint> previous;
  
  Chart({
    Key key,
    @required this.stream,
    @required this.previous
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.7,
      child: StreamBuilder<Object>(
        stream: this.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('Wait');
          }
          this.previous.add(snapshot.data);
          var _data = this.previous.toList();
          return charts.TimeSeriesChart(
            _createSampleData(_data),
            animate: true,
            // dateTimeFactory: charts.LocalDateTimeFactory(),
            domainAxis: _dateTimeAxisSpec,
            primaryMeasureAxis: _numericAxisSpec,
            behaviors: [
              _rangeAnnotation,
            ]
          );
        }
      ),
    );
  }

  final _dateTimeAxisSpec = charts.DateTimeAxisSpec(
    tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
      minute: charts.TimeFormatterSpec(
        format: 'HH:mm',
        transitionFormat: 'HH:mm:ss',
        ),
      ),
  );

  final _numericAxisSpec = charts.NumericAxisSpec(
      tickProviderSpec:
      charts.BasicNumericTickProviderSpec(zeroBound: false)
    );

  final _rangeAnnotation = charts.RangeAnnotation([
    charts.LineAnnotationSegment(
      70, charts.RangeAnnotationAxisType.measure,
      startLabel: 'Low blood sugar',
      color: charts.MaterialPalette.gray.shade300),
    charts.LineAnnotationSegment(
      130, charts.RangeAnnotationAxisType.measure,
      endLabel: 'High blood sugar',
      color: charts.MaterialPalette.gray.shade400),
    ]
  );
}

List<charts.Series<TimeSeriesPoint, DateTime>> _createSampleData(data) =>
  [
    charts.Series<TimeSeriesPoint, DateTime>(
      id: 'Blood Sugar',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (TimeSeriesPoint point, _) => point.time,
      measureFn: (TimeSeriesPoint point, _) => point.value,
      data: data,
    )
  ];