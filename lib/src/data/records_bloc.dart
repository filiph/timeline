import 'dart:async';
import 'dart:collection';

import 'package:rxdart/rxdart.dart';
import 'package:timeline/src/data/timeline_record.dart';

final _defaultRecords = [
  Record.simple("Agency Day SF", DateTime(2018, 8, 2)),
  Record.simple("SF Android", DateTime(2018, 8, 2)),
  Record.simple("iOS Devs Meetup", DateTime(2018, 8, 20)),
  Record.simple("DevFest Tokyo", DateTime(2018, 9, 1)),
  Record.simple("GDD China", DateTime(2018, 9, 21), const Duration(days: 2)),
  Record.simple("WomenWhoCode Hackathon", DateTime(2018, 9, 21)),
  Record.simple("DevFest Ukraine", DateTime(2018, 10, 12)),
  Record.simple("DevFest India", DateTime(2018, 10, 13)),
  Record.simple("DevFest Nantes", DateTime(2018, 10, 18)),
  Record.simple(
      "DroidCon London", DateTime(2018, 10, 26), const Duration(days: 2)),
  Record.simple(
      "ReactiveConf Prague", DateTime(2018, 10, 31), const Duration(days: 3)),
  Record.simple("Firebase DevSummit", DateTime(2018, 10, 29)),
  Record.simple("Android DevSummit", DateTime(2018, 11, 7)),
  Record.simple("DevFest Prague", DateTime(2018, 11, 9)),
  Record.simple("DevFest DACH", DateTime(2018, 11, 10)),
  Record.simple("DevFest Seoul", DateTime(2018, 11, 10)),
  Record.simple("GDE Summit", DateTime(2018, 11, 11), const Duration(days: 2)),
  Record.simple("Chrome DevSummit", DateTime(2018, 11, 12)),
  Record.simple("QCon", DateTime(2018, 11, 5)),
  Record.simple("Devoxx BE", DateTime(2018, 11, 17), const Duration(days: 5)),
  Record.simple(
      "GOTO Copenhagen", DateTime(2018, 11, 19), const Duration(days: 5)),
  Record.simple("London Event", DateTime(2018, 12, 3)),

  // ..sort((a, b) => b.duration.compareTo(a.duration))
];

class RecordChange {
  final Record before;
  final Record after;

  const RecordChange(this.before, this.after);
}

class RecordsBloc {
  List<Record> _records = List<Record>.from(_defaultRecords);

  final _additionController = StreamController<Record>();

  final _recordsSubject = BehaviorSubject<UnmodifiableListView<Record>>(
      seedValue: UnmodifiableListView(_defaultRecords));

  final _removalController = StreamController<Record>();

  final _recordChangeController = StreamController<RecordChange>();

  RecordsBloc() {
    _additionController.stream.listen(_handleNewRecord);
    _removalController.stream.listen(_handleRemoval);
    _recordChangeController.stream.listen(_handleRecordChange);
    _publishCurrentRecords();
  }

  Sink<Record> get addition => _additionController.sink;

  Sink<RecordChange> get recordChange => _recordChangeController.sink;

  Stream<UnmodifiableListView<Record>> get records => _recordsSubject.stream;

  Sink<Record> get removal => _removalController.sink;

  void close() {
    _additionController.close();
    _removalController.close();
    _recordChangeController.close();
  }

  void _handleNewRecord(Record record) {
    _records.add(record);
    _publishCurrentRecords();
  }

  void _handleRecordChange(RecordChange change) {
    assert(_records.contains(change.before));
    final index = _records.indexOf(change.before);
    _records[index] = change.after;
    _publishCurrentRecords();
  }

  void _handleRemoval(Record record) {
    assert(_records.contains(record));
    _records.remove(record);
    _publishCurrentRecords();
  }

  void _publishCurrentRecords() {
    _recordsSubject.add(UnmodifiableListView(_records));
  }
}
