import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'kiwi/KiwiInjector.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppInitService {
  static initApp() async {
    await Hive.initFlutter();
    await KiwiInjector.instance.init();
  }

}

bool isMobile() => Platform.isAndroid || Platform.isIOS;
