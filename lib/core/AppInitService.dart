import 'dart:io';

import 'package:kcal_counter_flutter/core/db/AppDatabase.dart';
import 'package:kcal_counter_flutter/core/library/CsvImportService.dart';
import 'package:kcal_counter_flutter/core/library/dao/LibraryEntryDao.dart';
import 'package:kcal_counter_flutter/core/library/model/CsvLibEntry.dart';
import 'kiwi/KiwiInjector.dart';

class AppInitService {
  static initApp() async {
    await KiwiInjector.instance.init();
  }

}

bool isMobile() => Platform.isAndroid || Platform.isIOS;
