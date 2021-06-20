class ConsumptionSummary {

  String dayName;
  int totalKcals;
  double totalCarbs;
  double totalFats;
  double totalProteins;
  int numberOfEntries;

  ConsumptionSummary(this.dayName, this.totalKcals, this.totalCarbs,
      this.totalFats, this.totalProteins, this.numberOfEntries);

  @override
  String toString() {
    return 'ConsumptionSummary{dayName: $dayName, totalKcals: $totalKcals, totalCarbs: $totalCarbs, totalFats: $totalFats, totalProteins: $totalProteins, numberOfEntries: $numberOfEntries}';
  }

}