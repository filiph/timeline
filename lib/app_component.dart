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
  final RecordsBloc recordsBloc;

  String editEventTitle = '';

  bool showEditDialog = false;

  TimelineRecord editEventCurrent;

  DatepickerComparison editEventRange;

  AppComponent(this.recordsBloc);

  void closeEditDialog() {
    showEditDialog = false;
    editEventCurrent = null;
  }

  void removeCurrentRecord() {
    // TODO ask first
    recordsBloc.removal.add(editEventCurrent);
    editEventTitle = '';
    closeEditDialog();
  }

  void saveEditEvent() {
    recordsBloc.addition.add(new TimelineRecord(
        editEventTitle, editEventRange.range.start.asUtcTime()));
    editEventTitle = '';
    editEventCurrent = null;
    closeEditDialog();
  }

  void startEdit(TimelineRecord record) {
    editEventCurrent = record;
    editEventTitle = record.title;
    final start = Date.fromTime(record.start);
    final end = Date.fromTime(record.completion);
    editEventRange = DatepickerComparison.noComparison(
        DatepickerDateRange.custom(start, end));
    showEditDialog = true;
  }

  void startNewRecord() {
    editEventTitle = '';
    showEditDialog = true;
  }
}
