import 'dart:async';
import 'dart:collection';

import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timeline/src/data/data.dart';
import 'package:timeline/src/data/record.dart';

class RecordChange {
  final Record before;
  final Record after;

  const RecordChange(this.before, this.after);
}

class RecordsBloc {
  final List<Record> _records = [];

  final _bulkDataRequestController = StreamController<Null>();

  final _additionController = StreamController<Record>();

  final _recordsSubject = BehaviorSubject<UnmodifiableListView<Record>>();

  final _removalController = StreamController<Record>();

  final _bulkChangeController = StreamController<Data>();

  final _recordChangeController = StreamController<RecordChange>();

  final _bulkDataSubject = BehaviorSubject<Data>();

  DateTime _currentDataTimestamp = new DateTime.utc(1900);

  RecordsBloc() {
    _additionController.stream.listen(_handleNewRecord);
    _removalController.stream.listen(_handleRemoval);
    _recordChangeController.stream.listen(_handleRecordChange);
    _bulkChangeController.stream.listen(_handleBulkChange);
    _bulkDataRequestController.stream.listen(_handleBulkDataRequest);

    _publishCurrentRecords();
  }

  Sink<Record> get addition => _additionController.sink;

  Sink<Data> get bulkChange => _bulkChangeController.sink;

  Stream<Data> get bulkData => _bulkDataSubject.stream;

  Sink<Null> get bulkDataRequest => _bulkDataRequestController.sink;

  Sink<RecordChange> get recordChange => _recordChangeController.sink;

  Stream<UnmodifiableListView<Record>> get records => _recordsSubject.stream;

  Sink<Record> get removal => _removalController.sink;

  void close() {
    _additionController.close();
    _removalController.close();
    _recordChangeController.close();
    _bulkDataSubject.close();
    _bulkChangeController.close();
    _bulkDataRequestController.close();
  }

  Data _buildData() {
    final data = Data((b) => b
      ..timestamp = _currentDataTimestamp
      ..records = new ListBuilder(_records));
    return data;
  }

  void _handleBulkChange(Data data) {
    _updateFromData(data);
    _publishCurrentRecords();
  }

  void _handleNewRecord(Record record) {
    _records.add(record);
    _publishCurrentRecords();
    _saveData();
  }

  void _handleRecordChange(RecordChange change) {
    assert(_records.contains(change.before));
    final index = _records.indexOf(change.before);
    _records[index] = change.after;
    _publishCurrentRecords();
    _saveData();
  }

  void _handleRemoval(Record record) {
    assert(_records.contains(record));
    _records.remove(record);

    _publishCurrentRecords();
    _saveData();
  }

  void _publishCurrentRecords() {
    // Sort by length so that longer events are at the bottom
    // of the timeline graph.
    _records.sort((a, b) => -a.durationInDays.compareTo(b.durationInDays));
    _recordsSubject.add(UnmodifiableListView(_records));
  }

  void _saveData() {
    _currentDataTimestamp = DateTime.now().toUtc();
    final data = _buildData();
    _bulkDataSubject.add(data);
  }

  void _updateFromData(Data data) {
    if (data.timestamp.isBefore(_currentDataTimestamp)) {
      print("Received old data. Dropping.");
      return;
    }
    _records.clear();
    _records.addAll(data.records);
  }

  void _handleBulkDataRequest(Null event) {
    final data = _buildData();
    _bulkDataSubject.add(data);
  }
}
