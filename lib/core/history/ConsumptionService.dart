import 'package:kcal_counter_flutter/core/history/dao/ConsumptionDao.dart';
import 'package:kcal_counter_flutter/core/history/dao/DayDao.dart';
import 'package:kcal_counter_flutter/core/history/model/Consumption.dart';
import 'package:kcal_counter_flutter/core/history/model/Day.dart';
import 'package:kcal_counter_flutter/core/library/LibEntry.dart';

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

  Future<List<Consumption>> getConsumptionForDay(int dayId) async {
    return await consumptionDao.getConsumptionByDay(dayId);
  }


  DateTime _getBeginningOfCurrentDay() {
    final now = DateTime.now();
    final todayBeginOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0);
    return todayBeginOfDay;
  }

  Future<void> saveConsumption(Day day, LibEntry pickedEntry,
      int quantity) async {
    final consumption = Consumption(
      null,
      day.id!,
      pickedEntry.name,
      quantity,
      pickedEntry.unit,
      quantity.toDouble() * pickedEntry.kcals.toDouble() ~/
          pickedEntry.perUnitCount.toDouble(),
      quantity.toDouble() * pickedEntry.carbs.toDouble() /
          pickedEntry.perUnitCount.toDouble(),
      quantity.toDouble() * pickedEntry.fat.toDouble() /
          pickedEntry.perUnitCount.toDouble(),
      quantity.toDouble() * pickedEntry.proteins.toDouble() /
          pickedEntry.perUnitCount.toDouble(),
      DateTime.now().millisecondsSinceEpoch
    );

    await consumptionDao.insert(consumption);
  }

}
