library record;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'record.g.dart';

abstract class Record implements Built<Record, RecordBuilder> {
  static const _maxShortTitleLength = 35;

  static Serializer<Record> get serializer => _$recordSerializer;

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

  int get durationInDays {
    return 1 + end.difference(start).inDays;
  }

  String get formattedRange {
    final buf = StringBuffer();
    final shortDateFormat = DateFormat.MMMd();

    // "Apr 7"
    buf.write(shortDateFormat.format(start));

    if (start.month != end.month) {
      //"-May 2"
      buf.write("-");
      buf.write(shortDateFormat.format(end));
    } else if (durationInDays > 1) {
      // "-11"
      buf.write("-${end.day}");
    }

    // ", 2018"
    buf.write(", ${end.year}");

    // "Apr 7-11, 2018"
    return buf.toString();
  }

  DateTime get start;

  String get title;
}
