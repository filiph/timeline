// GENERATED CODE - DO NOT MODIFY BY HAND

part of record;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

class _$Record extends Record {
  @override
  final DateTime end;
  @override
  final DateTime start;
  @override
  final String title;

  factory _$Record([void updates(RecordBuilder b)]) =>
      (new RecordBuilder()..update(updates)).build();

  _$Record._({this.end, this.start, this.title}) : super._() {
    if (end == null) throw new BuiltValueNullFieldError('Record', 'end');
    if (start == null) throw new BuiltValueNullFieldError('Record', 'start');
    if (title == null) throw new BuiltValueNullFieldError('Record', 'title');
  }

  @override
  Record rebuild(void updates(RecordBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  RecordBuilder toBuilder() => new RecordBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Record) return false;
    return end == other.end && start == other.start && title == other.title;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, end.hashCode), start.hashCode), title.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Record')
          ..add('end', end)
          ..add('start', start)
          ..add('title', title))
        .toString();
  }
}

class RecordBuilder implements Builder<Record, RecordBuilder> {
  _$Record _$v;

  DateTime _end;
  DateTime get end => _$this._end;
  set end(DateTime end) => _$this._end = end;

  DateTime _start;
  DateTime get start => _$this._start;
  set start(DateTime start) => _$this._start = start;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  RecordBuilder();

  RecordBuilder get _$this {
    if (_$v != null) {
      _end = _$v.end;
      _start = _$v.start;
      _title = _$v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Record other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Record;
  }

  @override
  void update(void updates(RecordBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Record build() {
    final _$result =
        _$v ?? new _$Record._(end: end, start: start, title: title);
    replace(_$result);
    return _$result;
  }
}
