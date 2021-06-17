
import 'package:floor/floor.dart';
import 'package:kcal_counter_flutter/core/history/model/Consumption.dart';

@dao
abstract class ConsumptionDao {

  @Query("SELECT * FROM Consumption WHERE dayId = :dayId ORDER BY addTimestampMillis DESC")
  Future<List<Consumption>> getConsumptionByDay(int dayId);

  @Insert()
  Future<void> insert(Consumption consumption);

  @Update()
  Future<void> update(Consumption consumption);

}