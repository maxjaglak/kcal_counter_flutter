class DateUtil {
  static String printDate(int timestamp) => timestamp != null ? DateTime.fromMicrosecondsSinceEpoch(timestamp*1000).toIso8601String().replaceFirst("T", " ") : "-";
}