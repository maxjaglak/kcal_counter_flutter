import 'package:bloc/bloc.dart';
import 'package:kcal_counter_flutter/core/library/CsvLibraryRepository.dart';
import 'package:kcal_counter_flutter/core/library/model/CsvLibEntry.dart';

class LibraryCubit extends Cubit<LibraryState> {

  final CsvLibraryRepository libraryRepository;

  LibraryCubit(this.libraryRepository) : super(LibraryState(loading: true)) {
    load();
  }

  void load() async {
    final entries = await libraryRepository.getAll();
    emit(LibraryState(entries: entries));
  }
}

class LibraryState {
  final bool loading;
  final List<CsvLibEntry>? entries;

  LibraryState({this.entries, this.loading = false});
}
