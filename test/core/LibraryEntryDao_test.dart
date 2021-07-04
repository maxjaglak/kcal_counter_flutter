import 'package:flutter_test/flutter_test.dart';
import 'package:kcal_counter_flutter/core/db/AppDatabase.dart';
import 'package:kcal_counter_flutter/core/kiwi/KiwiInjector.dart';
import 'package:kcal_counter_flutter/core/library/dao/LibraryEntryDao.dart';
import 'package:kcal_counter_flutter/core/library/model/LibraryEntry.dart';

void main() async {

  await KiwiInjector.instance.init();

  final LibraryEntryDao dao = KiwiInjector.instance.getContainer().resolve<LibraryEntryDao>();

  tearDownAll(() {
    final db = KiwiInjector.instance.getContainer().resolve<AppDatabase>();
    // db.
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