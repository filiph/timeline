import 'package:timeline/src/timeline/timeline_component.dart';

final records = [
  new TimelineRecord("Why we don't use OEM widgets", new DateTime(2017, 8, 1),
      const Duration(days: 30)),
  new TimelineRecord("How we do developer UX at Google",
      new DateTime(2017, 8, 10), const Duration(days: 45)),
  new TimelineRecord("Jake Wharton: My first week with Flutter",
      new DateTime(2017, 9, 20), const Duration(days: 60)),
  new TimelineRecord("How we built the Hamilton app with Flutter",
      new DateTime(2017, 10, 15), const Duration(days: 60)),
  new TimelineRecord(
      "Testing in Flutter: How does it differ from traditional mobile app testing",
      new DateTime(2017, 9, 1),
      const Duration(days: 45)),
  new TimelineRecord(
      "How we implemented a top-voted mobile design in 800 LOC",
      new DateTime(2017, 7, 15),
      const Duration(days: 30)),
  new TimelineRecord(
      "Extreme composition: Composition waaay over inheritance",
      new DateTime(2017, 8, 20),
      const Duration(days: 30)),
  new TimelineRecord("What is live programming?", new DateTime(2017, 10, 1),
      const Duration(days: 30)),
  new TimelineRecord(
      "Lovingly recreating the Texas Instruments TI-35 calculator for iOS and Android",
      new DateTime(2017, 10, 10),
      const Duration(days: 60)),
  new TimelineRecord("Using Redux with Flutter", new DateTime(2017, 9, 15),
      const Duration(days: 45)),
  new TimelineRecord(
      "Why we built almost all of our UI stack in a GC language",
      new DateTime(2017, 8, 15),
      const Duration(days: 30)),

  // ----- events
  new TimelineRecord("Devoxx", new DateTime(2017, 11, 6)),
  new TimelineRecord("JavaZone", new DateTime(2017, 9, 13)),
  new TimelineRecord("Strange Loop", new DateTime(2017, 9, 28)),
  new TimelineRecord("GDD Europe", new DateTime(2017, 9, 5)),
  new TimelineRecord("ReactiveConf", new DateTime(2017, 10, 25)),
  new TimelineRecord("GOTO CPH", new DateTime(2017, 10, 1)),
  new TimelineRecord("Øredev", new DateTime(2017, 11, 16)),
  new TimelineRecord("Codemotion DE", new DateTime(2017, 10, 12)),
  new TimelineRecord("Firebase Summit", new DateTime(2017, 10, 31)),
  new TimelineRecord(
      "DevFest Season", new DateTime(2017, 12, 1), const Duration(days: 90)),
]..sort((a, b) => b.duration.compareTo(a.duration));
