import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:kcal_counter_flutter/core/config/config.dart';
import 'package:kcal_counter_flutter/core/db/app_database.dart';
import 'package:kcal_counter_flutter/core/history/consumption_service.dart';
import 'package:kcal_counter_flutter/core/history/date_service.dart';
import 'package:kcal_counter_flutter/core/history/dao/consuption_dao.dart';
import 'package:kcal_counter_flutter/core/history/dao/day_dao.dart';
import 'package:kcal_counter_flutter/core/library/csv_export_service.dart';
import 'package:kcal_counter_flutter/core/library/csv_import_service.dart';
import 'package:kcal_counter_flutter/core/library/library_query_service.dart';
import 'package:kcal_counter_flutter/core/library/dao/library_entry_dao.dart';
import 'package:kcal_counter_flutter/core/preferences/preferences_service.dart';
import 'package:kcal_counter_flutter/ui/history/history_cubit.dart';
import 'package:kcal_counter_flutter/ui/libraryedit/library_edit_cubit.dart';
import 'package:kcal_counter_flutter/ui/nav/navigation_bloc.dart';
import 'package:kcal_counter_flutter/ui/settingstab/settings_tab_cubit.dart';
import 'package:kcal_counter_flutter/ui/todaytab/today_view_cubit.dart';
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
    container.registerInstance(PreferencesService());

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
