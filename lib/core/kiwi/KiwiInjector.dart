import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:kcal_counter_flutter/core/config/Config.dart';
import 'package:kcal_counter_flutter/core/db/AppDatabase.dart';
import 'package:kcal_counter_flutter/core/history/ConsumptionService.dart';
import 'package:kcal_counter_flutter/core/history/DateService.dart';
import 'package:kcal_counter_flutter/core/history/dao/ConsumptionDao.dart';
import 'package:kcal_counter_flutter/core/history/dao/DayDao.dart';
import 'package:kcal_counter_flutter/core/library/CsvExportService.dart';
import 'package:kcal_counter_flutter/core/library/CsvImportService.dart';
import 'package:kcal_counter_flutter/core/library/LibraryQueryService.dart';
import 'package:kcal_counter_flutter/core/library/dao/LibraryEntryDao.dart';
import 'package:kcal_counter_flutter/ui/history/HistoryCubit.dart';
import 'package:kcal_counter_flutter/ui/libraryedit/LibraryEditCubit.dart';
import 'package:kcal_counter_flutter/ui/nav/NavigationBloc.dart';
import 'package:kcal_counter_flutter/ui/settingstab/SettingsTabCubit.dart';
import 'package:kcal_counter_flutter/ui/todaytab/TodayViewCubit.dart';
import 'package:kiwi/kiwi.dart';

class KiwiInjector {
  static KiwiInjector instance = KiwiInjector();

  KiwiContainer? _container = null;

  KiwiContainer getContainer() {
    return _container!;
  }

  Future<void> init() async {
    final container = KiwiContainer();

    container.registerSingleton((c) => Config());

    final db = await $FloorAppDatabase
        .databaseBuilder("oo.max.kcalCounter.db")
        .build();
    final DayDao dayDao = db.dayDao;
    final ConsumptionDao consumptionDao = db.consumptionDao;
    final LibraryEntryDao libraryEntryDao = db.libraryDao;

    container.registerInstance(db);

    container.registerInstance(dayDao);
    container.registerInstance(consumptionDao);
    container.registerInstance(libraryEntryDao);

    container.registerInstance(DateService());

    container.registerSingleton((c) => ConsumptionService(c.resolve<DayDao>(),
        c.resolve<ConsumptionDao>(), c.resolve<DateService>()));

    container.registerSingleton(
        (c) => CsvImportService(c.resolve<LibraryEntryDao>()));

    container.registerSingleton(
        (c) => CsvExportService(c.resolve<LibraryEntryDao>()));

    container.registerSingleton((c) => LibraryQueryService(
        c.resolve<LibraryEntryDao>(), c.resolve<AppDatabase>()));

    container.registerInstance(NavigationBloc());
    container.registerFactory(
        (c) => TodayViewCubit(c.resolve<ConsumptionService>()));

    container.registerFactory((c) => HistoryCubit(c.resolve<DayDao>()));

    container
        .registerFactory((c) => LibraryEditCubit(c.resolve<LibraryEntryDao>()));

    container.registerFactory((c) => SettingsTabCubit(
        c.resolve<LibraryEntryDao>(),
        c.resolve<CsvImportService>(),
        c.resolve<CsvExportService>()));

    this._container = container;
  }

  bool isMobile() => Platform.isAndroid || Platform.isIOS;
}
