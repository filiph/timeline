// Copyright (c) 2017, filiph. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:timeline/src/timeline/timeline_component.dart';

import 'data.dart' as data;

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives, TimelineComponent],
  providers: const [materialProviders],
)
class AppComponent {
  String table = "...";

  final records = data.records;

  void buildTable() {
    var buf = new StringBuffer();
    for (var r in data.records) {
      buf.write(r.title);
      buf.write('\t');
      buf.write(r.start.toIso8601String().substring(0, 10));
      buf.write('\t');
      buf.write(r.completion.toIso8601String().substring(0, 10));
      buf.writeln();
    }
    table = buf.toString();
  }
}
