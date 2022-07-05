import 'package:kcal_counter_flutter/core/db/app_database.dart';
import 'package:kcal_counter_flutter/core/library/dao/library_entry_dao.dart';

import 'model/library_entry.dart';

class LibraryQueryService {
  final LibraryEntryDao libraryEntryDao;
  final AppDatabase appDatabase;

  LibraryQueryService(this.libraryEntryDao, this.appDatabase);

  Future<List<LibraryEntry>> search(
      String? query, int pageKey, int pageSize) async {
    if (query == null) {
      return await libraryEntryDao.getPage(pageSize, pageSize * pageKey);
    } else {
      List<LibraryEntry> result = await _simpleSearch(pageSize, pageKey, query);
      if (result.isNotEmpty) {
        return result;
      }

      result = await _widerSearch(result, pageSize, pageKey, query);
      if (result.isNotEmpty) {
        return result;
      }

      return await _searchForAllWords(query);
    }
  }

  Future<List<LibraryEntry>> _simpleSearch(int pageSize, int pageKey, String query) async {
    final result = await libraryEntryDao.getPageWithQuery(
        pageSize, pageSize * pageKey, "${query}%");
    return result;
  }

  Future<List<LibraryEntry>> _widerSearch(List<LibraryEntry> result, int pageSize, int pageKey, String query) async {
    result = await libraryEntryDao.getPageWithQuery(
        pageSize, pageSize * pageKey, "%${query}%");
    return result;
  }

  Future<List<LibraryEntry>> _searchForAllWords(String query) async {
    final split = query.split(" ");
    if (split.isEmpty) return [];

    List<LibraryEntry> fullResult = [];
    for (String part in split) {
      var partialResult = await libraryEntryDao.searchLibrary("%${part}%");
      fullResult.addAll(partialResult);
    }
    fullResult = fullResult
        .where((element) => element.containsFullQuery(split))
        .toSet()
        .toList();

    return fullResult;
  }

}
