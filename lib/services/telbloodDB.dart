import 'package:telblood/services/telbloodDB_api.dart';
import 'package:telblood/models/sensor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DB implements DBApi {
  final _firestore = Firestore.instance;
  final _telBlood = 'telBlood';
  Future<bool> addMinData(List<TimeSeriesPoint> points) async {
    double _mean = points.map((point) => point.value).reduce((a, b) => a + b) / points.length;
    DateTime _time = points[points.length ~/ 2].time;
    DocumentReference _docRef = await _firestore.collection(_telBlood).add(
      {
        'uid' : points[0].uid,
        'value' : _mean,
        'time' : _time
      }
    );
    return _docRef.documentID != null;
  }
  @override
  Stream<List<TimeSeriesPoint>> getPointsList(String uid) {
    // TODO: implement getPoints
    return _firestore
      .collection(_telBlood) .where('uid',
      isEqualTo: uid)
      .snapshots()
      .map((QuerySnapshot snapshot) {
      List<TimeSeriesPoint> _journalDocs =
      snapshot.documents.map((doc) =>
      TimeSeriesPoint.fromDoc(doc)).toList();
      return _journalDocs;
      });
  }
}