import 'package:bloc/bloc.dart';
import 'package:kcal_counter_flutter/core/library/dao/LibraryEntryDao.dart';

class SettingsTabCubit extends Cubit<SettingsTabState> {

  final LibraryEntryDao libraryEntryDao;

  SettingsTabCubit(this.libraryEntryDao) : super(SettingsTabState());

  void deleteLibrary() async {
    emit(SettingsTabState(loading: true));
    await libraryEntryDao.deleteAll();
    emit(SettingsTabState());
  }

}

class SettingsTabState {
  final bool loading;

  SettingsTabState({this.loading = false});
}