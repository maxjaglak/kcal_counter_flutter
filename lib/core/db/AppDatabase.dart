import 'dart:async';

import 'package:floor/floor.dart';
import 'package:kcal_counter_flutter/core/history/dao/ConsumptionDao.dart';
import 'package:kcal_counter_flutter/core/history/dao/DayDao.dart';
import 'package:kcal_counter_flutter/core/history/model/Consumption.dart';
import 'package:kcal_counter_flutter/core/history/model/Day.dart';
import 'package:kcal_counter_flutter/core/library/dao/LibraryEntryDao.dart';
import 'package:kcal_counter_flutter/core/library/model/LibraryEntry.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'AppDatabase.g.dart';

@Database(version: 1, entities: [Day, Consumption, LibraryEntry])
abstract class AppDatabase extends FloorDatabase  {

  DayDao get dayDao;
  ConsumptionDao get consumptionDao;
  LibraryEntryDao get libraryDao;
  
}