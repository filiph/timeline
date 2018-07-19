import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:timeline/src/data/data.dart';
import 'package:timeline/src/data/record.dart';

part 'serializers.g.dart';

@SerializersFor(const [Data, Record])
Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(new StandardJsonPlugin())).build();
