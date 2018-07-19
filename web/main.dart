// Copyright (c) 2017, filiph. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:angular/angular.dart';
import 'package:timeline/app_component.template.dart' as ng;
import 'package:timeline/src/data/records_bloc.dart';
import 'package:timeline/src/services/storage.dart';

import 'main.template.dart' as mainNg;

void main() {
  runApp(ng.AppComponentNgFactory, createInjector: recordsBlocInjector);
}

@GenerateInjector(const [
  ClassProvider(StorageService, useClass: LocalStorageService),
  ClassProvider(RecordsBloc),
])
final InjectorFactory recordsBlocInjector = mainNg.recordsBlocInjector$Injector;

class LocalStorageService implements StorageService {
  String load() {
    return window.localStorage['data'];
  }

  void save(String data) {
    window.localStorage['data'] = data;
  }
}
