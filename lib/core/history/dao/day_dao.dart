import 'package:floor/floor.dart';
import 'package:kcal_counter_flutter/core/history/model/day.dart';

@dao
abstract class DayDao {

  @Query("SELECT * FROM Day ORDER BY id DESC LIMIT 1")
  Future<Day?> getLastDay();
  
  @Query("SELECT * FROM Day ORDER BY id DESC")
  Future<List<Day>> getDays();

  @Query("SELECT * FROM Day WHERE id = :dayId LIMIT 1")
  Future<Day?> getDayById(int dayId);

  @Insert()
  Future<void> insert(Day day);

  @Update()
  Future<void> update(Day day);
  
}