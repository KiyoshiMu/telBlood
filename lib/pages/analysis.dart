import 'package:flutter/material.dart';
import 'package:telblood/widgets/share.dart';
import 'package:telblood/models/fixedqueue.dart';
import 'package:telblood/models/sensor.dart';

class AnalysisPage extends StatelessWidget {
  final FixedQueue<TimeSeriesPoint> data;
  AnalysisPage(this.data);

  Future<double> _getResult(FixedQueue<TimeSeriesPoint> data) async {
    await Future.delayed(const Duration(seconds: 1));
    int _score = data.length;
    for (TimeSeriesPoint _v in data) {
      _score -= _v.value > 130 ? 1 : 0;
      _score -= _v.value < 70 ? 1 : 0;
    }
    return _score / data.length * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analysis'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/sugar.jpg',
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: FutureBuilder(
                    future: _getResult(data),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        double result = snapshot.data;
                        return Text(
                          '${result.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.lightGreen,
                            fontSize: 100,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Text(
                  "Normal value ranges may vary slightly among different laboratories.\n"
                  "You stay in the Normal range most of the time\n"
                  "Good Job!",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Share(),
            ],
          ),
        ),
      ),
    );
  }
}
