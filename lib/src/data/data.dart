library data;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:timeline/src/data/record.dart';

part 'data.g.dart';

final Data defaultData = Data((b) => b
  ..timestamp = DateTime.utc(1900)
  ..records = ListBuilder<Record>([
    Record.simple("Agency Day SF", DateTime.utc(2018, 8, 2)),
    Record.simple("SF Android", DateTime.utc(2018, 8, 2)),
    Record.simple("iOS Devs Meetup", DateTime.utc(2018, 8, 20)),
    Record.simple("DevFest Tokyo", DateTime.utc(2018, 9, 1)),
    Record.simple(
        "GDD China", DateTime.utc(2018, 9, 21), const Duration(days: 2)),
    Record.simple("WomenWhoCode Hackathon", DateTime.utc(2018, 9, 21)),
    Record.simple("DevFest Ukraine", DateTime.utc(2018, 10, 12)),
    Record.simple("DevFest India", DateTime.utc(2018, 10, 13)),
    Record.simple("DevFest Nantes", DateTime.utc(2018, 10, 18)),
    Record.simple(
        "DroidCon London", DateTime.utc(2018, 10, 26), const Duration(days: 2)),
    Record.simple("ReactiveConf Prague", DateTime.utc(2018, 10, 31),
        const Duration(days: 3)),
    Record.simple("Firebase DevSummit", DateTime.utc(2018, 10, 29)),
    Record.simple("Android DevSummit", DateTime.utc(2018, 11, 7)),
    Record.simple("DevFest Prague", DateTime.utc(2018, 11, 9)),
    Record.simple("DevFest DACH", DateTime.utc(2018, 11, 10)),
    Record.simple("DevFest Seoul", DateTime.utc(2018, 11, 10)),
    Record.simple(
        "GDE Summit", DateTime.utc(2018, 11, 11), const Duration(days: 2)),
    Record.simple("Chrome DevSummit", DateTime.utc(2018, 11, 12)),
    Record.simple("QCon", DateTime.utc(2018, 11, 5)),
    Record.simple(
        "Devoxx BE", DateTime.utc(2018, 11, 17), const Duration(days: 5)),
    Record.simple(
        "GOTO Copenhagen", DateTime.utc(2018, 11, 19), const Duration(days: 5)),
    // Record.simple("London Event", DateTime.utc(2018, 12, 3)),
  ]));

typedef void DataBuilderUpdater(DataBuilder b);

abstract class Data implements Built<Data, DataBuilder> {
  static Serializer<Data> get serializer => _$dataSerializer;

  factory Data([DataBuilderUpdater updates]) = _$Data;

  factory Data.empty() => Data((b) => b
      ..records = ListBuilder<Record>()
      ..timestamp = DateTime.now().toUtc());

  Data._();

  BuiltList<Record> get records;

  DateTime get timestamp;
}
