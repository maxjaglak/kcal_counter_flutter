import 'dart:io';

import 'package:kcal_counter_flutter/core/db/app_database.dart';
import 'package:kcal_counter_flutter/core/library/csv_import_service.dart';
import 'package:kcal_counter_flutter/core/library/dao/library_entry_dao.dart';
import 'package:kcal_counter_flutter/core/library/model/csv_lib_entry.dart';
import 'kiwi/kiwi_injector.dart';

class AppInitService {
  static initApp() async {
    await KiwiInjector.instance.init();
  }

}

bool isMobile() => Platform.isAndroid || Platform.isIOS;
