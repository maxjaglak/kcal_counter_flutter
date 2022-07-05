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
    on<TermsAcceptedEvent>((event, emit) async {
      await preferencesService.setTermsAccepted(true);
      await _emitAppState(emit);
    });
    on<InitEventInitializationDone>((event, emit) async {
      await _emitAppState(emit);
    });
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    AppInitService.initApp().then((_) {
      this._container = KiwiInjector.instance.getContainer();
      this.preferencesService =
          KiwiInjector.instance.getContainer().resolve<PreferencesService>();
      this.add(InitEventInitializationDone());
    });
  }

  Future<void> _emitAppState(Emitter<InitState> emit) async {
    if (_container == null) {
      emit(InitStateSplash());
    } else {
      bool areTermsAcceptedKey = await preferencesService.areTermsAccepted();
      if (areTermsAcceptedKey) {
        emit(InitStateMainNav());
      } else {
        emit(TermsScreen());
      }
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
