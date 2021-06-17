class LibEntry {
  String name;
  int kcals;
  double carbs;
  double fat;
  double proteins;

  LibEntry(this.name, this.kcals, this.carbs, this.fat, this.proteins);

  bool containsQuery(List<String> query) {
    return query.any((element) => name.toLowerCase().contains(element));
  }

  @override
  String toString() {
    return 'LibEntry{name: $name, kcals: $kcals, carbs: $carbs, fat: $fat, proteins: $proteins}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LibEntry &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          kcals == other.kcals &&
          carbs == other.carbs &&
          fat == other.fat &&
          proteins == other.proteins;

  @override
  int get hashCode =>
      name.hashCode ^
      kcals.hashCode ^
      carbs.hashCode ^
      fat.hashCode ^
      proteins.hashCode;
}