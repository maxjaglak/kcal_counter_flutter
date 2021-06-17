import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:kcal_counter_flutter/core/AppInitService.dart';
import 'package:kcal_counter_flutter/core/kiwi/KiwiInjector.dart';
import 'package:kiwi/kiwi.dart';

class InitBloc extends Bloc<InitEvent, InitState> {
  KiwiContainer? _container;

  InitBloc() : super(InitStateSplash()) {
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    AppInitService.initApp().then((_) {
      this._container = KiwiInjector.instance.getContainer();
      this.add(InitEventInitializationDone());
    });
  }

  @override
  Stream<InitState> mapEventToState(InitEvent event) async* {
    try {
      if (_container == null) {
        yield InitStateSplash();
      } else {
        yield InitStateMainNav();
      }
    } on Exception catch (e) {
      print(e);
      yield InitStateError();
    }
  }
}

abstract class InitEvent {}

class InitEventInitializationDone extends InitEvent {}

abstract class InitState {}

class InitStateSplash extends InitState {}

class InitStateMainNav extends InitState {}

class InitStateError extends InitState {}
