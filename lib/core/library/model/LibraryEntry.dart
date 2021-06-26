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

  LibraryEntry(this.id, this.name, this.unitName, this.perUnitCount, this.kcals,
      this.carbs, this.fat, this.protein);

  @override
  String toString() {
    return 'LibraryEntry{id: $id, name: $name, unitName: $unitName, perUnitCount: $perUnitCount, kcals: $kcals, carbs: $carbs, fat: $fat, protein: $protein}';
  }

}