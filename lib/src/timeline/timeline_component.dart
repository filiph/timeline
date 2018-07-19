// Copyright (c) 2017, filiph. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:collection';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_components/material_button/material_button.dart';
import 'package:timeline/src/data/records_bloc.dart';
import 'package:timeline/src/data/record.dart';

class MonthTick {
  final String title;
  final DateTime time;

  MonthTick(DateTime time)
      : time = time,
        title = _monthToString(time.month);

  static String _monthToString(int m) {
    switch (m) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
      default:
        throw new ArgumentError(m);
    }
  }
}

@Component(
  selector: 'timeline',
  styleUrls: const ['timeline_component.css'],
  templateUrl: 'timeline_component.html',
  pipes: [
    AsyncPipe,
  ],
  directives: const [
    NgFor,
    MaterialButtonComponent,
  ],
)
class TimelineComponent {
  static final _defaultLowestTime = new DateTime(1900);

  static final _defaultHighestTime = new DateTime(2100);

  UnmodifiableListView<Record> records;

  final RecordsBloc bloc;

  @ViewChild('vis')
  Element vis;

  String editEventName = '';

  int padding = 20;

  final int width = 900;

  final int height = 600;

  DateTime _lowestTime = _defaultLowestTime;

  DateTime _highestTime = _defaultHighestTime;

  Map<Record, int> _tracks = {};

  List<MonthTick> monthTicks = [];

  TimelineComponent(this.bloc) {
    bloc.records.listen(_updateView);
  }

  void download() {
    var data = vis.outerHtml;
    var dataComponent = Uri.encodeComponent(data);
    var dataUri = "data:application/octet-stream,$dataComponent";
    var el = new AnchorElement(href: dataUri);
    el.attributes['download'] = 'timeline.svg';
    el.style.display = 'none';
    document.body.append(el);
    el.click();
    el.remove();
  }

  int recordToY(Record r) {
    var track = _tracks[r];
    if (track == null) return 0;
    return height - 50 - track * 40;
  }

  int timeToX(DateTime time) {
    assert(time.isAfter(_lowestTime) || time.isAtSameMomentAs(_lowestTime));
    assert(time.isBefore(_highestTime) || time.isAtSameMomentAs(_highestTime));
    final whole = _highestTime.millisecondsSinceEpoch -
        _lowestTime.millisecondsSinceEpoch;
    final ratio =
        (time.millisecondsSinceEpoch - _lowestTime.millisecondsSinceEpoch) /
            whole;
    return (padding + (width - 2 * padding) * ratio).round();
  }

  void _updateView(UnmodifiableListView<Record> records) {
    monthTicks.clear();
    _tracks.clear();
    if (records.isEmpty) return;
    _lowestTime = records
        .map<DateTime>((r) => r.start)
        .fold(null, (p, n) => p == null ? n : (p.isBefore(n) ? p : n));
    _highestTime = records
        .map<DateTime>((r) => r.end)
        .fold(null, (p, n) => p == null ? n : (n.isAfter(p) ? n : p));
    var wholeDuration = _highestTime.difference(_lowestTime);
    var padding = wholeDuration * 1.1;
    var tmp = _highestTime;
    _highestTime = _lowestTime.add(padding);
    _lowestTime = tmp.subtract(padding);

    var month = new DateTime(_lowestTime.year, _lowestTime.month + 1);
    while (month.isBefore(_highestTime)) {
      monthTicks.add(new MonthTick(month));
      month = new DateTime(month.year, month.month + 1);
    }

    for (var r in records) {
      int track = 0;
      while (true) {
        bool taken = false;
        for (var key in _tracks.keys.where((k) => _tracks[k] == track)) {
          var startWithBuffer = key.start.subtract(const Duration(days: 20));
          var endWithBuffer = key.end.add(const Duration(days: 20));
          var startsInside = r.start.isAfter(startWithBuffer) &&
              r.start.isBefore(endWithBuffer);
          var endsInside =
              r.end.isAfter(startWithBuffer) && r.end.isBefore(endWithBuffer);
          if (startsInside || endsInside /* TODO: encompasses */) {
            taken = true;
            break;
          }
        }
        if (taken) {
          track += 1;
          continue;
        } else {
          _tracks[r] = track;
          break;
        }
      }
    }
    new Timer(const Duration(milliseconds: 100), () {
      this.records = records;
    });
  }
}
