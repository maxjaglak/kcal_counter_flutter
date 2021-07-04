import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kcal_counter_flutter/core/library/dao/LibraryEntryDao.dart';
import 'package:kcal_counter_flutter/core/library/model/LibraryEntry.dart';

class LibraryEditCubit extends Cubit<LibraryEditState> {
  final LibraryEntryDao libraryEntryDao;
  LibraryEntry? _libraryEntry;

  LibraryEditCubit(this.libraryEntryDao)
      : super(LibraryEditState(loading: true));

  void init(LibraryEntry? libraryEntry) {
    this._libraryEntry = libraryEntry;
    if (this._libraryEntry == null) {
      this._libraryEntry = LibraryEntry(null, "", "", 0, 0, 0, 0, 0, false);
    }

    emit(LibraryEditState(libraryEntry: this._libraryEntry));
  }

  Future<void> save(LibraryEntry libraryEntry) async {
    if(libraryEntry.id == null) {
      await libraryEntryDao.insert(libraryEntry);
    } else {
      await libraryEntryDao.update(libraryEntry);
    }
  }
}

class LibraryEditState {
  final bool loading;
  final LibraryEntry? libraryEntry;

  LibraryEditState({this.loading = false, this.libraryEntry});
}
