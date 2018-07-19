// Copyright (c) 2017, filiph. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:timeline/src/data/records_bloc.dart';
import 'package:timeline/src/data/timeline_record.dart';
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
    RecordsBloc,
    materialProviders,
    MaterialButtonComponent,
    materialInputDirectives,
  ],
)
class AppComponent {
  final RecordsBloc bloc;

  String editEventTitle = '';

  bool showEditDialog = false;

  Record editEventCurrent;

  DatepickerComparison editEventRange;

  AppComponent(this.bloc);

  void closeEditDialog() {
    showEditDialog = false;
    editEventCurrent = null;
  }

  void removeCurrentRecord() {
    // TODO ask first
    bloc.removal.add(editEventCurrent);
    editEventTitle = '';
    closeEditDialog();
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
    return Record.simple(editEventTitle, start); // TODO: end
  }

  void _editCurrentEvent() {
    bloc.recordChange
        .add(new RecordChange(editEventCurrent, _constructFromEditForm()));
    editEventTitle = '';
    editEventCurrent = null;
    closeEditDialog();
  }
}
