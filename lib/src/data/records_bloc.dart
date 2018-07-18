import 'dart:async';
import 'dart:collection';

import 'package:rxdart/rxdart.dart';
import 'package:timeline/src/data/timeline_record.dart';

final _defaultRecords = [
  TimelineRecord("Agency Day SF", DateTime(2018, 8, 2)),
  TimelineRecord("SF Android", DateTime(2018, 8, 2)),
  TimelineRecord("iOS Devs Meetup", DateTime(2018, 8, 20)),
  TimelineRecord("DevFest Tokyo", DateTime(2018, 9, 1)),
  TimelineRecord("GDD China", DateTime(2018, 9, 21), const Duration(days: 2)),
  TimelineRecord("WomenWhoCode Hackathon", DateTime(2018, 9, 21)),
  TimelineRecord("DevFest Ukraine", DateTime(2018, 10, 12)),
  TimelineRecord("DevFest India", DateTime(2018, 10, 13)),
  TimelineRecord("DevFest Nantes", DateTime(2018, 10, 18)),
  TimelineRecord(
      "DroidCon London", DateTime(2018, 10, 26), const Duration(days: 2)),
  TimelineRecord(
      "ReactiveConf Prague", DateTime(2018, 10, 31), const Duration(days: 3)),
  TimelineRecord("Firebase DevSummit", DateTime(2018, 10, 29)),
  TimelineRecord("Android DevSummit", DateTime(2018, 11, 7)),
  TimelineRecord("DevFest Prague", DateTime(2018, 11, 9)),
  TimelineRecord("DevFest DACH", DateTime(2018, 11, 10)),
  TimelineRecord("DevFest Seoul", DateTime(2018, 11, 10)),
  TimelineRecord("GDE Summit", DateTime(2018, 11, 11), const Duration(days: 2)),
  TimelineRecord("Chrome DevSummit", DateTime(2018, 11, 12)),
  TimelineRecord("QCon", DateTime(2018, 11, 5)),
  TimelineRecord("Devoxx BE", DateTime(2018, 11, 17), const Duration(days: 5)),
  TimelineRecord(
      "GOTO Copenhagen", DateTime(2018, 11, 19), const Duration(days: 5)),
  TimelineRecord("London Event", DateTime(2018, 12, 3)),

  // ..sort((a, b) => b.duration.compareTo(a.duration))
];

class RecordsBloc {
  List<TimelineRecord> _records = List<TimelineRecord>.from(_defaultRecords);

  final _additionController = StreamController<TimelineRecord>();

  final _recordsSubject =
      BehaviorSubject<UnmodifiableListView<TimelineRecord>>();

  Sink<TimelineRecord> get removal => _removalController.sink;

  final _removalController = StreamController<TimelineRecord>();



  RecordsBloc() {
    _additionController.stream.listen(_handleNewRecord);
    _removalController.stream.listen(_handleRemoval);
    _publishCurrentRecords();
  }

  Sink<TimelineRecord> get addition => _additionController.sink;

  Stream<UnmodifiableListView<TimelineRecord>> get records =>
      _recordsSubject.stream;

  void close() {
    _additionController.close();
  }

  void _handleNewRecord(TimelineRecord record) {
    _records.add(record);
    _publishCurrentRecords();
  }

  void _publishCurrentRecords() {
    _recordsSubject.add(UnmodifiableListView(_records));
  }

  void _handleRemoval(TimelineRecord record) {
    assert(_records.contains(record));
    _records.remove(record);
    _publishCurrentRecords();
  }
}
