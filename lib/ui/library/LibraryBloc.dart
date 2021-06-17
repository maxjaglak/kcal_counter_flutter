import 'package:bloc/bloc.dart';
import 'package:kcal_counter_flutter/core/library/LibEntry.dart';
import 'package:kcal_counter_flutter/core/library/LibraryRepository.dart';

class LibraryCubit extends Cubit<LibraryState> {

  final LibraryRepository libraryRepository;

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
  final List<LibEntry>? entries;

  LibraryState({this.entries, this.loading = false});
}
