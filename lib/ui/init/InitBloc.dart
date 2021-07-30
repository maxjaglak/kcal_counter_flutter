import 'package:bloc/bloc.dart';
import 'package:kcal_counter_flutter/core/AppInitService.dart';
import 'package:kcal_counter_flutter/core/kiwi/KiwiInjector.dart';
import 'package:kcal_counter_flutter/core/preferences/PreferencesService.dart';
import 'package:kiwi/kiwi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitBloc extends Bloc<InitEvent, InitState> {
  KiwiContainer? _container;

  late PreferencesService preferencesService;

  InitBloc() : super(InitStateSplash()) {
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    AppInitService.initApp().then((_) {
      this._container = KiwiInjector.instance.getContainer();
      this.preferencesService = KiwiInjector.instance.getContainer().resolve<PreferencesService>();
      this.add(InitEventInitializationDone());
    });
  }

  @override
  Stream<InitState> mapEventToState(InitEvent event) async* {
    try {
      if(event is TermsAcceptedEvent) {
        await preferencesService.setTermsAccepted(true);
      }
      if (_container == null) {
        yield InitStateSplash();
      } else {
        bool areTermsAcceptedKey = await preferencesService.areTermsAccepted();
        if(areTermsAcceptedKey) {
          yield InitStateMainNav();
        } else {
          yield TermsScreen();
        }
      }
    } on Exception catch (e) {
      print(e);
      yield InitStateError();
    }
  }
}

abstract class InitEvent {}

class InitEventInitializationDone extends InitEvent {}

class TermsAcceptedEvent extends InitEvent {}

abstract class InitState {}

class InitStateSplash extends InitState {}

class InitStateMainNav extends InitState {}

class InitStateError extends InitState {}

class TermsScreen extends InitState {}
