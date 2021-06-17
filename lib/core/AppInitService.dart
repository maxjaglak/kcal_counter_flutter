import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'kiwi/KiwiInjector.dart';

class AppInitService {
  static initApp() async {
    await KiwiInjector.instance.init();
  }

}

bool isMobile() => Platform.isAndroid || Platform.isIOS;
