import 'package:kcal_counter_flutter/core/library/model/LibraryEntry.dart';

class CsvLibEntry {
  String name;
  String unit;
  int perUnitCount;
  int kcals;
  double carbs;
  double fat;
  double proteins;

  CsvLibEntry(this.name, this.unit, this.perUnitCount, this.kcals, this.carbs,
      this.fat, this.proteins);

  bool containsQuery(List<String> query) {
    return query.any((element) => name.toLowerCase().contains(element));
  }

  @override
  String toString() {
    return 'CsvLibEntry{name: $name, unit: $unit, perUnitCount: $perUnitCount, kcals: $kcals, carbs: $carbs, fat: $fat, proteins: $proteins}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CsvLibEntry &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              unit == other.unit &&
              kcals == other.kcals &&
              carbs == other.carbs &&
              fat == other.fat &&
              proteins == other.proteins;

  @override
  int get hashCode =>
      name.hashCode ^
      unit.hashCode ^
      kcals.hashCode ^
      carbs.hashCode ^
      fat.hashCode ^
      proteins.hashCode;

  toLibraryEntry() =>
      LibraryEntry(
          null,
          name,
          unit,
          perUnitCount,
          kcals,
          carbs,
          fat,
          proteins);

}