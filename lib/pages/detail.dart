import 'package:flutter/material.dart';
import 'package:telblood/widgets/share.dart';
import 'package:telblood/pages/analysis.dart';
import 'package:telblood/widgets/chart.dart';
import 'package:telblood/models/fixedqueue.dart';
import 'package:telblood/models/sensor.dart';
import 'package:telblood/models/config.dart';

class DataPage extends StatelessWidget {

  final String type;
  DataPage(this.type);

  Future<double> _getResult (FixedQueue<TimeSeriesPoint> data) async {
    int _score = data.length;
    for (TimeSeriesPoint _v in data) {
      _score -= _v.value > 130 ? 1 : 0;
      _score -= _v.value < 70 ? 1 : 0;
    }
    return _score / data.length * 100;
  }

  void _toAnalysis(BuildContext context, FixedQueue<TimeSeriesPoint> data) {
    _getResult(data)
    .then((_res) {
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => AnalysisPage(_res)
      )
      );
    })
    .catchError((error) {
      print(error);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    String title;
    FixedQueue<TimeSeriesPoint> data;
    Stream stream;
    switch (this.type) {
      case 'Glucose': {
        title = Configs.of(context).gluConfig.title;
        data = Configs.of(context).gluConfig.recorder.previous;
        stream = Configs.of(context).gluConfig.recorder.flowin;
      }
      break;
      default: {
        title = Configs.of(context).bpConfig.title;
        data = Configs.of(context).bpConfig.recorder.previous;
        stream = Configs.of(context).bpConfig.recorder.flowin;
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
              Chart(previous: data, stream: stream,),
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