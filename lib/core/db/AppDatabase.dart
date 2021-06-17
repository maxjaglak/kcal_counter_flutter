import 'dart:async';

import 'package:floor/floor.dart';
import 'package:kcal_counter_flutter/core/history/dao/ConsumptionDao.dart';
import 'package:kcal_counter_flutter/core/history/dao/DayDao.dart';
import 'package:kcal_counter_flutter/core/history/model/Consumption.dart';
import 'package:kcal_counter_flutter/core/history/model/Day.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';

part 'AppDatabase.g.dart';

@Database(version: 1, entities: [Day, Consumption])
abstract class AppDatabase extends FloorDatabase  {

  DayDao get dayDao;
  ConsumptionDao get consumptionDao;
  
}