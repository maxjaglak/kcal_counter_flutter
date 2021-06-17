class LibEntry {
  String name;
  String unit;
  int kcals;
  double carbs;
  double fat;
  double proteins;

  LibEntry(this.name, this.unit, this.kcals, this.carbs, this.fat, this.proteins);

  bool containsQuery(List<String> query) {
    return query.any((element) => name.toLowerCase().contains(element));
  }

  @override
  String toString() {
    return 'LibEntry{name: $name, unit: $unit, kcals: $kcals, carbs: $carbs, fat: $fat, proteins: $proteins}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LibEntry &&
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
}