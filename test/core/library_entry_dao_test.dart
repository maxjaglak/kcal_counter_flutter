import 'package:flutter_test/flutter_test.dart';
import 'package:kcal_counter_flutter/core/db/app_database.dart';
import 'package:kcal_counter_flutter/core/kiwi/kiwi_injector.dart';
import 'package:kcal_counter_flutter/core/library/dao/library_entry_dao.dart';
import 'package:kcal_counter_flutter/core/library/model/library_entry.dart';

void main() async {

  late LibraryEntryDao dao;

  setUp(() async {
    final db = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    dao = db.libraryDao;
  });

  test("Should execute like query", () async {
    //given
    final entry1 = LibraryEntry((null), "Red apple", "100g", 100, 10, 10, 10, 10, false);
    final entry2 = LibraryEntry((null), "Green apple", "100g", 100, 10, 10, 10, 10, false);

    await dao.insert(entry1);
    await dao.insert(entry2);

    //when
    final result = await dao.getPageWithQuery(10, 0, "%app%");

    //then
    expect(result, isNotEmpty);
  });

}