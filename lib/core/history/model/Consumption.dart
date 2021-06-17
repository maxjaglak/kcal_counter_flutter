import 'package:floor/floor.dart';

@entity
class Consumption {

  @PrimaryKey(autoGenerate: true)
  int? id;

  int dayId;
  String name;
  int amount;
  String calculationUnit;
  int kcals;
  double carbs;
  double fat;
  double protein;
  int addTimestampMillis;

  Consumption(this.id, this.dayId, this.name, this.amount, this.calculationUnit,
      this.kcals, this.carbs, this.fat, this.protein, this.addTimestampMillis);

  @override
  String toString() {
    return 'Consumption{id: $id, dayId: $dayId, name: $name, amount: $amount, calculationUnit: $calculationUnit, kcals: $kcals, carbs: $carbs, fat: $fat, protein: $protein, addTimestampMillis: $addTimestampMillis}';
  }
}