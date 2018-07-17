import 'package:timeline/src/timeline/timeline_component.dart';

final records = [
  // ----- events
  new TimelineRecord("Agency Day SF", new DateTime(2018, 8, 2)),
  new TimelineRecord("SF Android", new DateTime(2018, 8, 2)),
  new TimelineRecord("iOS Devs Meetup", new DateTime(2018, 8, 20)),
  new TimelineRecord("DevFest Tokyo", new DateTime(2018, 9, 1)),
  new TimelineRecord("GDD China", new DateTime(2018, 9, 21), const Duration(days: 2)),
  new TimelineRecord("WomenWhoCode Hackathon", new DateTime(2018, 9, 21)),
  new TimelineRecord("DevFest Ukraine", new DateTime(2018, 10, 12)),
  new TimelineRecord("DevFest India", new DateTime(2018, 10, 13)),
  new TimelineRecord("DevFest Nantes", new DateTime(2018, 10, 18)),
  new TimelineRecord("DroidCon London", new DateTime(2018, 10, 26), const Duration(days: 2)),
  new TimelineRecord("ReactiveConf Prague", new DateTime(2018, 10, 31), const Duration(days: 3)),
  new TimelineRecord("Firebase DevSummit", new DateTime(2018, 10, 29)),
  new TimelineRecord("Android DevSummit", new DateTime(2018, 11, 7)),
  new TimelineRecord("DevFest Prague", new DateTime(2018, 11, 9)),
  new TimelineRecord("DevFest DACH", new DateTime(2018, 11, 10)),
  new TimelineRecord("DevFest Seoul", new DateTime(2018, 11, 10)),
  new TimelineRecord("GDE Summit", new DateTime(2018, 11, 11), const Duration(days: 2)),
  new TimelineRecord("Chrome DevSummit", new DateTime(2018, 11, 12)),
  new TimelineRecord("QCon", new DateTime(2018, 11, 5)),
  new TimelineRecord("Devoxx BE", new DateTime(2018, 11, 17), const Duration(days: 5)),
  new TimelineRecord("GOTO Copenhagen", new DateTime(2018, 11, 19), const Duration(days: 5)),
  new TimelineRecord("London Event", new DateTime(2018, 12, 3)),
]..sort((a, b) => b.duration.compareTo(a.duration));
