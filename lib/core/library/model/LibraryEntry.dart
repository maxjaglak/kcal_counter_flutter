import 'package:floor/floor.dart';

@entity
class LibraryEntry {

  @PrimaryKey(autoGenerate: true)
  int? id;

  String name;
  String unitName;
  int perUnitCount;
  int kcals;
  double carbs;
  double fat;
  double protein;
  bool isFavourite;

  LibraryEntry(this.id, this.name, this.unitName, this.perUnitCount, this.kcals,
      this.carbs, this.fat, this.protein, this.isFavourite);

  bool containsQuery(List<String> query) {
    return query.any((element) => name.toLowerCase().contains(element));
  }

  bool containsFullQuery(List<String> query) {
    return query.every((element) => name.toLowerCase().contains(element.toLowerCase()));
  }

  @override
  String toString() {
    return 'LibraryEntry{id: $id, name: $name, unitName: $unitName, perUnitCount: $perUnitCount, kcals: $kcals, carbs: $carbs, fat: $fat, protein: $protein, isFavourite: $isFavourite}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LibraryEntry &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}