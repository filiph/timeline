
class TimelineRecord {
  static const _maxShortTitleLength = 35;
  final DateTime completion;
  final Duration duration;
  final String title;

  final String color = "blue";

  const TimelineRecord(this.title, this.completion,
      [this.duration = const Duration(days: 1)]);

  String get shortTitle {
    if (title.length <= _maxShortTitleLength) return title;
    const ellipsis = "…";
    final half = (_maxShortTitleLength / 2 - ellipsis.length / 2).floor();
    return "${title.substring(0, half)}"
        "$ellipsis"
        "${title.substring(title.length - half)}";
  }

  DateTime get start => completion.subtract(duration);
}
