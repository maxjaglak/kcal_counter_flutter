import 'package:kcal_counter_flutter/core/history/dao/ConsumptionDao.dart';
import 'package:kcal_counter_flutter/core/history/dao/DayDao.dart';
import 'package:kcal_counter_flutter/core/history/model/Day.dart';

class ConsumptionService {
  final DayDao dayDao;
  final ConsumptionDao consumptionDao;

  ConsumptionService(this.dayDao, this.consumptionDao);

  Future<Day?> getTodayDay() async {
    final lastDay = await dayDao.getLastDay();
    final todayBeginOfDay = _getBeginningOfCurrentDay();

    if (lastDay?.dayBeginTimestamp != todayBeginOfDay.millisecondsSinceEpoch) {
      return null;
    }
    return lastDay;
  }

  Future<void> openDay() async {
    final today = await getTodayDay();
    if (today != null) {
      return;
    }

    DateTime todayBeginOfDay = _getBeginningOfCurrentDay();

    final day = Day(null, todayBeginOfDay.millisecondsSinceEpoch);

    await dayDao.insert(day);
  }

  DateTime _getBeginningOfCurrentDay() {
    final now = DateTime.now();
    final todayBeginOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0);
    return todayBeginOfDay;
  }
}
