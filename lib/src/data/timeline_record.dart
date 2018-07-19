library record;

import 'package:built_value/built_value.dart';
import 'package:meta/meta.dart';

part 'timeline_record.g.dart';

abstract class Record implements Built<Record, RecordBuilder> {
  static const _maxShortTitleLength = 35;

  factory Record({
    @required String title,
    @required DateTime start,
    @required DateTime end,
  }) = _$Record._;

  factory Record.simple(String title, DateTime start, [Duration duration]) {
    final end = duration == null ? start : start.add(duration);
    return Record(title: title, start: start, end: end);
  }

  Record._();

  DateTime get end;

  String get shortTitle {
    if (title.length <= _maxShortTitleLength) return title;
    const ellipsis = "…";
    final half = (_maxShortTitleLength / 2 - ellipsis.length / 2).floor();
    return "${title.substring(0, half)}"
        "$ellipsis"
        "${title.substring(title.length - half)}";
  }

  DateTime get start;

  String get title;
}
