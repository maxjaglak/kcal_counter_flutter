import 'package:floor/floor.dart';

@entity
class Consumption {

  @primaryKey
  int id;

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
}