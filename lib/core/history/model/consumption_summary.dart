import 'package:kcal_counter_flutter/core/history/model/day.dart';

class ConsumptionSummary {

  Day day;
  int totalKcals;
  double totalCarbs;
  double totalFats;
  double totalProteins;
  int numberOfEntries;

  ConsumptionSummary(this.day, this.totalKcals, this.totalCarbs,
      this.totalFats, this.totalProteins, this.numberOfEntries);

  @override
  String toString() {
    return 'ConsumptionSummary{dayName: $day, totalKcals: $totalKcals, totalCarbs: $totalCarbs, totalFats: $totalFats, totalProteins: $totalProteins, numberOfEntries: $numberOfEntries}';
  }

}