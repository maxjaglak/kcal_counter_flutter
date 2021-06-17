import 'package:floor/floor.dart';
import 'package:kcal_counter_flutter/core/history/model/Day.dart';

@dao
abstract class DayDao {

  @Query("SELECT * FROM Day ORDER BY id DESC LIMIT 1")
  Future<Day?> getLastDay();
  
  @Query("SELECT * FROM Day ORDER BY id DESC")
  Future<List<Day>> getDays();

  @Insert()
  Future<void> insert(Day day);

  @Update()
  Future<void> update(Day day);
  
}