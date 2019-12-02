import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telblood/services/sensors.dart';
import 'package:telblood/widgets/share.dart';
import 'package:telblood/pages/analysis.dart';
import 'package:telblood/widgets/chart.dart';
import 'package:telblood/models/fixedqueue.dart';
import 'package:telblood/models/sensor.dart';

class DataPage extends StatelessWidget {
  final String type;
  DataPage(this.type);

  void _toAnalysis(BuildContext context, FixedQueue<TimeSeriesPoint> data) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AnalysisPage(data)));
  }

  @override
  Widget build(BuildContext context) {
    String title;
    FixedQueue<TimeSeriesPoint> data;
    Stream stream;
    switch (this.type) {
      case 'Glucose':
        {
          title = Provider.of<Sensors>(context).gluConfig.title;
          data = Provider.of<Sensors>(context).gluConfig.recorder.previous;
          stream = Provider.of<Sensors>(context).gluConfig.recorder.flowin;
        }
        break;
      default:
        {
          title = Provider.of<Sensors>(context).bpConfig.title;
          data = Provider.of<Sensors>(context).bpConfig.recorder.previous;
          stream = Provider.of<Sensors>(context).bpConfig.recorder.flowin;
        }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Chart(
                previous: data,
                stream: stream,
              ),
              Share(),
            ],
          ),
        ),
      ),
      floatingActionButton: IconButton(
        icon: Icon(
          Icons.sentiment_very_satisfied,
          color: Colors.lightGreen,
          size: 50,
        ),
        onPressed: () {
          _toAnalysis(context, data);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
