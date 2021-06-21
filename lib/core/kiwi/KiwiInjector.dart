import 'dart:io';
import 'package:kcal_counter_flutter/core/config/Config.dart';
import 'package:kcal_counter_flutter/core/db/AppDatabase.dart';
import 'package:kcal_counter_flutter/core/history/ConsumptionService.dart';
import 'package:kcal_counter_flutter/core/history/DateService.dart';
import 'package:kcal_counter_flutter/core/history/dao/ConsumptionDao.dart';
import 'package:kcal_counter_flutter/core/history/dao/DayDao.dart';
import 'package:kcal_counter_flutter/core/library/LibraryRepository.dart';
import 'package:kcal_counter_flutter/ui/history/HistoryCubit.dart';
import 'package:kcal_counter_flutter/ui/library/LibraryBloc.dart';
import 'package:kcal_counter_flutter/ui/nav/NavigationBloc.dart';
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

    container.registerInstance(dayDao);
    container.registerInstance(consumptionDao);

    container.registerInstance(DateService());

    container.registerSingleton((c) => ConsumptionService(c.resolve<DayDao>(),
        c.resolve<ConsumptionDao>(), c.resolve<DateService>()));

    container.registerSingleton((c) => LibraryRepository());

    container.registerInstance(NavigationBloc());
    container
        .registerSingleton((c) => LibraryCubit(c.resolve<LibraryRepository>()));
    container.registerSingleton(
        (c) => TodayViewCubit(c.resolve<ConsumptionService>()));

    container.registerSingleton((c) => HistoryCubit(c.resolve<DayDao>()));

    this._container = container;
  }

  bool isMobile() => Platform.isAndroid || Platform.isIOS;
}
