import 'dart:async';

import 'package:floor/floor.dart';
import 'package:kcal_counter_flutter/core/history/dao/consuption_dao.dart';
import 'package:kcal_counter_flutter/core/history/dao/day_dao.dart';
import 'package:kcal_counter_flutter/core/history/model/consumption.dart';
import 'package:kcal_counter_flutter/core/history/model/day.dart';
import 'package:kcal_counter_flutter/core/library/dao/library_entry_dao.dart';
import 'package:kcal_counter_flutter/core/library/model/library_entry.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [Day, Consumption, LibraryEntry])
abstract class AppDatabase extends FloorDatabase  {

  DayDao get dayDao;
  ConsumptionDao get consumptionDao;
  LibraryEntryDao get libraryDao;
  
}