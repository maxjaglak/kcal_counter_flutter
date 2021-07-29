import 'package:flutter/cupertino.dart';
import 'package:kcal_counter_flutter/core/history/DateService.dart';
import 'package:kcal_counter_flutter/core/history/dao/ConsumptionDao.dart';
import 'package:kcal_counter_flutter/core/history/dao/DayDao.dart';
import 'package:kcal_counter_flutter/core/history/model/Consumption.dart';
import 'package:kcal_counter_flutter/core/history/model/ConsumptionSummary.dart';
import 'package:kcal_counter_flutter/core/history/model/Day.dart';
import 'package:kcal_counter_flutter/core/library/model/CsvLibEntry.dart';
import 'package:kcal_counter_flutter/core/library/model/LibraryEntry.dart';

class ConsumptionService {
  final DayDao dayDao;
  final ConsumptionDao consumptionDao;
  final DateService dateService;

  ConsumptionService(this.dayDao, this.consumptionDao,
      this.dateService);

  Future<Day?> getTodayDay() async {
    final lastDay = await dayDao.getLastDay();
    final todayBeginOfDay = dateService.getBeginningOfCurrentDay();

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

    DateTime todayBeginOfDay = dateService.getBeginningOfCurrentDay();

    final day = Day(null, todayBeginOfDay.millisecondsSinceEpoch);

    await dayDao.insert(day);
  }

  Future<List<Consumption>> getConsumptionForDay(int dayId) async {
    return await consumptionDao.getConsumptionByDay(dayId);
  }

  Future<void> saveConsumption(Day day, LibraryEntry pickedEntry,
      int quantity) async {
    final consumption = Consumption(
        null,
        day.id!,
        pickedEntry.name,
        quantity,
        pickedEntry.unitName,
        quantity.toDouble() * pickedEntry.kcals.toDouble() ~/
            pickedEntry.perUnitCount.toDouble(),
        quantity.toDouble() * pickedEntry.carbs.toDouble() /
            pickedEntry.perUnitCount.toDouble(),
        quantity.toDouble() * pickedEntry.fat.toDouble() /
            pickedEntry.perUnitCount.toDouble(),
        quantity.toDouble() * pickedEntry.protein.toDouble() /
            pickedEntry.perUnitCount.toDouble(),
        DateTime
            .now()
            .millisecondsSinceEpoch
    );

    await consumptionDao.insert(consumption);
  }

  Future<ConsumptionSummary> getCosumptionSummaryForDay(int dayId) async {
    final Day? day = await dayDao.getDayById(dayId);
    if(day == null) throw Exception("no such day");
    final List<Consumption> consumptions = await consumptionDao
        .getConsumptionByDay(dayId);

    int totalKcals = 0;
    double totalCarbs = 0;
    double totalFats = 0;
    double totalProteins = 0;

    for (Consumption consumption in consumptions) {
      totalKcals += consumption.kcals;
      totalCarbs += consumption.carbs;
      totalFats += consumption.fat;
      totalProteins += consumption.protein;
    }

    return ConsumptionSummary(
        dateService.printDate(day), totalKcals, totalCarbs, totalFats,
        totalProteins, consumptions.length
    );
  }

  Future<void> deleteConsumption(Consumption consumption) async {
    await consumptionDao.deleteConsumption(consumption);
  }

}
