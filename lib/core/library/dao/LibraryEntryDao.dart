import 'package:floor/floor.dart';
import 'package:kcal_counter_flutter/core/library/model/LibraryEntry.dart';

@dao
abstract class LibraryEntryDao {

  @Query("SELECT * FROM LibraryEntry WHERE name like :query")
  Future<List<LibraryEntry>> searchLibrary(String query);

  @Update()
  Future<void> update(LibraryEntry libraryEntry);

  @Insert()
  Future<void> insert(LibraryEntry libraryEntry);

  @Query("SELECT * FROM LibraryEntry ORDER BY isFavourite DESC, id LIMIT :limit OFFSET :offset")
  Future<List<LibraryEntry>> getPage(int limit, int offset);

  @Query("SELECT * FROM LibraryEntry WHERE name LIKE :query ORDER BY isFavourite DESC, id LIMIT :limit OFFSET :offset")
  Future<List<LibraryEntry>> getPageWithQuery(int limit, int offset, String query);

  @Query("SELECT * FROM LibraryEntry ORDER BY id")
  Future<List<LibraryEntry>> getAll();

  @delete
  Future<void> deleteEntry(LibraryEntry entry);

}