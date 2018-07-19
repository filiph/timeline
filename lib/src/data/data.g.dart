// GENERATED CODE - DO NOT MODIFY BY HAND

part of data;

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

Serializer<Data> _$dataSerializer = new _$DataSerializer();

class _$DataSerializer implements StructuredSerializer<Data> {
  @override
  final Iterable<Type> types = const [Data, _$Data];
  @override
  final String wireName = 'Data';

  @override
  Iterable serialize(Serializers serializers, Data object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'records',
      serializers.serialize(object.records,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Record)])),
      'timestamp',
      serializers.serialize(object.timestamp,
          specifiedType: const FullType(DateTime)),
    ];

    return result;
  }

  @override
  Data deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'records':
          result.records.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Record)]))
              as BuiltList);
          break;
        case 'timestamp':
          result.timestamp = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
      }
    }

    return result.build();
  }
}

class _$Data extends Data {
  @override
  final BuiltList<Record> records;
  @override
  final DateTime timestamp;

  factory _$Data([void updates(DataBuilder b)]) =>
      (new DataBuilder()..update(updates)).build();

  _$Data._({this.records, this.timestamp}) : super._() {
    if (records == null) throw new BuiltValueNullFieldError('Data', 'records');
    if (timestamp == null)
      throw new BuiltValueNullFieldError('Data', 'timestamp');
  }

  @override
  Data rebuild(void updates(DataBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  DataBuilder toBuilder() => new DataBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Data) return false;
    return records == other.records && timestamp == other.timestamp;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, records.hashCode), timestamp.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Data')
          ..add('records', records)
          ..add('timestamp', timestamp))
        .toString();
  }
}

class DataBuilder implements Builder<Data, DataBuilder> {
  _$Data _$v;

  ListBuilder<Record> _records;
  ListBuilder<Record> get records =>
      _$this._records ??= new ListBuilder<Record>();
  set records(ListBuilder<Record> records) => _$this._records = records;

  DateTime _timestamp;
  DateTime get timestamp => _$this._timestamp;
  set timestamp(DateTime timestamp) => _$this._timestamp = timestamp;

  DataBuilder();

  DataBuilder get _$this {
    if (_$v != null) {
      _records = _$v.records?.toBuilder();
      _timestamp = _$v.timestamp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Data other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Data;
  }

  @override
  void update(void updates(DataBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Data build() {
    _$Data _$result;
    try {
      _$result =
          _$v ?? new _$Data._(records: records.build(), timestamp: timestamp);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'records';
        records.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Data', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
