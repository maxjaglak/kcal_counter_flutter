import 'dart:io';
import 'package:kcal_counter_flutter/core/config/Config.dart';
import 'package:kcal_counter_flutter/core/library/LibraryRepository.dart';
import 'package:kcal_counter_flutter/ui/library/LibraryBloc.dart';
import 'package:kcal_counter_flutter/ui/nav/NavigationBloc.dart';
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

    // final hf =
    //     await HiveFactory.create(container.resolve<PreferencesService>());
    // container.registerSingleton((c) => hf);

    container.registerSingleton((c) => LibraryRepository());

    container.registerInstance(NavigationBloc());
    container.registerSingleton((c) => LibraryCubit(c.resolve<LibraryRepository>()));

    this._container = container;
  }

  bool isMobile() => Platform.isAndroid || Platform.isIOS;
}
