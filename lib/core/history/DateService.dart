import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'model/Day.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DateService {
  String printDate(Day day) {
    final beginOfToday = getBeginningOfCurrentDay().millisecondsSinceEpoch;
    if(day.dayBeginTimestamp == beginOfToday) {
      return "Dzisiaj";
    }
    final beginOfYesterday = getBeginningOfYesterday().millisecondsSinceEpoch;
    if(day.dayBeginTimestamp == beginOfToday) {
      return "Wczoraj";
    }

    final format = DateFormat("yyyy-MM-dd");
    final date = DateTime.fromMillisecondsSinceEpoch(day.dayBeginTimestamp);
    return format.format(date);
  }

  DateTime getBeginningOfYesterday() {
    return getBeginningOfCurrentDay().subtract(Duration(days: 1));
  }

  DateTime getBeginningOfCurrentDay() {
    final now = DateTime.now();
    final todayBeginOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0);
    return todayBeginOfDay;
  }

}