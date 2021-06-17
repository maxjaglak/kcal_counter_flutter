
import 'package:flutter_test/flutter_test.dart';
import 'package:kcal_counter_flutter/core/library/LibraryRepository.dart';

void main() async {

  TestWidgetsFlutterBinding.ensureInitialized();

  test("try load data from csv", () async {
    final entries = await LibraryRepository().getAll();
    print(entries);
  });

}