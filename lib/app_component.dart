// Copyright (c) 2017, filiph. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:timeline/src/data/data.dart';
import 'package:timeline/src/data/record.dart';
import 'package:timeline/src/data/records_bloc.dart';
import 'package:timeline/src/data/serializers.dart';
import 'package:timeline/src/services/storage.dart';
import 'package:timeline/src/timeline/timeline_component.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  pipes: [
    AsyncPipe,
    DatePipe,
  ],
  directives: const [
    NgFor,
    NgIf,
    TimelineComponent,
    materialDirectives,
    MaterialDatepickerComponent,
  ],
  providers: const [
    materialProviders,
    MaterialButtonComponent,
    materialInputDirectives,
  ],
)
class AppComponent implements OnInit {
  static final _jsonEncoderPretty = JsonEncoder.withIndent('  ');

  final RecordsBloc bloc;

  String editEventTitle = '';

  bool showEditDialog = false;

  bool showEditAsTextDialog = false;

  Record editEventCurrent;

  final StorageService storageService;

  final Date maxSelectableDate = Date(DateTime.now().year + 20);

  final Date minSelectableDate = Date(1900);

  DatepickerComparison editEventRange;

  String editAsTextData = '';

  AppComponent(this.bloc, this.storageService);

  void clearAllRecords() {
    bloc.bulkChange.add(new Data.empty());
  }

  void closeEditAsTextDialog() {
    showEditAsTextDialog = false;
  }

  void closeEditDialog() {
    showEditDialog = false;
    editEventCurrent = null;
  }

  void fillWithExampleData() {
    final defaultDataWithLatestTimestamp =
        defaultData.rebuild((b) => b..timestamp = DateTime.now().toUtc());
    bloc.bulkChange.add(defaultDataWithLatestTimestamp);
    _saveBulkData(defaultDataWithLatestTimestamp);
  }

  @override
  void ngOnInit() {
    final dataString = storageService.load();
    if (dataString != null) {
      final data = serializers.deserialize(json.decode(dataString));
      bloc.bulkChange.add(data);
    } else {
      bloc.bulkChange.add(defaultData);
    }

    bloc.bulkData.listen(_saveBulkData);
  }

  void removeCurrentRecord() {
    // TODO ask first
    bloc.removal.add(editEventCurrent);
    editEventTitle = '';
    closeEditDialog();
  }

  void saveEditAsText() {
    final data = serializers.deserialize(json.decode(editAsTextData));
    bloc.bulkChange.add(data);
    // Force to save the data.
    bloc.bulkDataRequest.add(null);
    showEditAsTextDialog = false;
  }

  void saveEditEvent() {
    if (editEventCurrent != null) {
      _editCurrentEvent();
    } else {
      _addNewEvent();
    }
  }

  void startEdit(Record record) {
    editEventCurrent = record;
    editEventTitle = record.title;
    final start = Date.fromTime(record.start);
    final end = Date.fromTime(record.end);
    editEventRange = DatepickerComparison.noComparison(
        DatepickerDateRange.custom(start, end));
    showEditDialog = true;
  }

  void startEditAsText() {
    showEditAsTextDialog = true;
    // Force-refresh the data.
    bloc.bulkDataRequest.add(null);
  }

  void startNewRecord() {
    editEventTitle = '';
    showEditDialog = true;
  }

  void _addNewEvent() {
    bloc.addition.add(_constructFromEditForm());
    editEventTitle = '';
    editEventCurrent = null;
    closeEditDialog();
  }

  Record _constructFromEditForm() {
    final start = editEventRange.range.start.asUtcTime();
    final duration = editEventRange.range.end.asUtcTime().difference(start);
    return Record.simple(editEventTitle, start, duration);
  }

  void _editCurrentEvent() {
    bloc.recordChange
        .add(new RecordChange(editEventCurrent, _constructFromEditForm()));
    editEventTitle = '';
    editEventCurrent = null;
    closeEditDialog();
  }

  void _saveBulkData(Data data) {
    final serialized = serializers.serialize(data);
    final jsonString = _jsonEncoderPretty.convert(serialized);
    editAsTextData = jsonString;
    storageService.save(jsonString);
  }
}
