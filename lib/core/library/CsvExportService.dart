import 'dart:io';

import 'package:kcal_counter_flutter/core/library/dao/LibraryEntryDao.dart';
import 'package:kcal_counter_flutter/core/library/model/LibraryEntry.dart';
import 'package:kcal_counter_flutter/ui/tools/RoundingHelper.dart';
import 'package:path_provider/path_provider.dart';

class CsvExportService {
  final LibraryEntryDao libraryEntryDao;
  final RoundingHelper roundingHelper = RoundingHelper();

  CsvExportService(this.libraryEntryDao);

  Future<File> exportLibraryAsCsvFile() async {
    final output = await _createOutputFile();

    final allEntries = await libraryEntryDao.getAll();
    for (LibraryEntry entry in allEntries) {
      final csvLine = _toCsvLine(entry);
      await output.writeAsString(csvLine, mode: FileMode.append, flush: true);
      await output.writeAsString("\n", mode: FileMode.append, flush: true);
    }

    return output;
  }

  Future<File> _createOutputFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final output = File(directory.path + "/export.csv");
    if (output.existsSync()) {
      await output.delete();
    }
    await output.create();
    return output;
  }

  _toCsvLine(LibraryEntry entry) {
    List<String> data = [
      entry.name,
      _wrapQuotes(entry.perUnitCount.toString()),
      entry.unitName,
      _wrapQuotes(entry.kcals.toString()),
      _wrapQuotes(roundingHelper.roundOneDecimalPlace(entry.carbs)),
      _wrapQuotes(roundingHelper.roundOneDecimalPlace(entry.fat)),
      _wrapQuotes(roundingHelper.roundOneDecimalPlace(entry.protein)),
    ];

    return data.join(";");
  }

  String _wrapQuotes(String text) => "\"$text\"";
}
