import 'package:bloc/bloc.dart';
import 'package:file_picker/src/platform_file.dart';
import 'package:kcal_counter_flutter/core/error/AppException.dart';
import 'package:kcal_counter_flutter/core/library/CsvImportService.dart';
import 'package:kcal_counter_flutter/core/library/dao/LibraryEntryDao.dart';

class SettingsTabCubit extends Cubit<SettingsTabState> {

  final LibraryEntryDao libraryEntryDao;
  final CsvImportService csvImportService;

  SettingsTabCubit(this.libraryEntryDao, this.csvImportService) : super(SettingsTabState());

  void deleteLibrary() async {
    emit(SettingsTabState(loading: true));
    await libraryEntryDao.deleteAll();
    emit(SettingsTabState(success: "Usunięto"));
  }

  void importLibrary(PlatformFile file) async {
    try {
      emit(SettingsTabState(loading: true));
      await csvImportService.importCsvLibrary(file);
      emit(SettingsTabState(success: "Import zakończony"));
    } on AppException catch(appException) {
      print(appException);
      emit(SettingsTabState(error: appException.error.getMessage()));
    } on Exception catch(e) {
      print(e);
      emit(SettingsTabState(error: AppError.GENERAL_ERROR.getMessage()));
    }
  }

}

class SettingsTabState {
  final bool loading;
  final String? error;
  final String? success;

  SettingsTabState({this.loading = false, this.error, this.success});
}