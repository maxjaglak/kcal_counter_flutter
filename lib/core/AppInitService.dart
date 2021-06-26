import 'dart:io';

import 'package:kcal_counter_flutter/core/db/AppDatabase.dart';
import 'package:kcal_counter_flutter/core/library/CsvLibraryRepository.dart';
import 'package:kcal_counter_flutter/core/library/dao/LibraryEntryDao.dart';
import 'package:kcal_counter_flutter/core/library/model/CsvLibEntry.dart';
import 'kiwi/KiwiInjector.dart';

class AppInitService {
  static initApp() async {
    await KiwiInjector.instance.init();

    await _importCsvLibrary();
  }

  static Future _importCsvLibrary() async {
    final container = KiwiInjector.instance.getContainer();
    final csvLibraryRepository = container.resolve<CsvLibraryRepository>();
    final db = container.resolve<AppDatabase>();
    final libraryDao = container.resolve<LibraryEntryDao>();

    final existingEntries = await libraryDao.getPage(10, 0);

    if(existingEntries.isNotEmpty) {
      print("there is already sth in the library, skipping initial import");
      return;
    }

    final start = DateTime.now();

    try {
      final entries = await csvLibraryRepository.getAll();
      for(CsvLibEntry entry in entries) {
        final libraryEntry = entry.toLibraryEntry();
        await libraryDao.insert(libraryEntry);
      }
    } on Exception catch (e) {
      print(e);
    }

    final end = DateTime.now();

    final durationMillis = end.millisecondsSinceEpoch - start.millisecondsSinceEpoch;

    print("Loading time: $durationMillis ms");
  }

}

bool isMobile() => Platform.isAndroid || Platform.isIOS;
