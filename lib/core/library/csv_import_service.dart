import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:kcal_counter_flutter/core/error/app_exception.dart';
import 'package:kcal_counter_flutter/core/library/dao/library_entry_dao.dart';

import 'model/csv_lib_entry.dart';

class CsvImportService {

  final LibraryEntryDao libraryDao;

  CsvImportService(this.libraryDao);

  Future<void> importCsvLibrary(PlatformFile file) async {
    print("Trying to load library from file: ${file.name}, extension: ${file.extension}");

    if(file.extension != "csv") {
      print("Not a .csv file!");
      throw AppException(AppError.INPUT_FILE_NOT_A_CSV);
    }

    final start = DateTime.now();

    try {
      String fileContent = _readFileContent(file);
      final entries = await _readValues(fileContent);
      for(CsvLibEntry entry in entries) {
        final libraryEntry = entry.toLibraryEntry();
        await libraryDao.insert(libraryEntry);
      }
    } on Exception catch (e) {
      print(e);
      throw AppException(AppError.INVALID_CSV_FILE);
    }

    final end = DateTime.now();

    final durationMillis = end.millisecondsSinceEpoch - start.millisecondsSinceEpoch;

    print("Loading time: $durationMillis ms");
  }

  String _readFileContent(PlatformFile file) {
    try {
      if (file.bytes != null && file.bytes?.isNotEmpty == true) {
        return Utf8Decoder().convert(file.bytes!);
      }
    } on Exception catch(e) {
      print(e);
      throw AppException(AppError.INVALID_CSV_FILE, message: "Failed to load content");
    }
    throw AppException(AppError.INVALID_CSV_FILE, message: "Failed to load content, bytes are null?");
  }

  Future<List<CsvLibEntry>> _readValues(String libraryDataCsv) async {
    final List<List<dynamic>> lines = CsvToListConverter().convert(libraryDataCsv, fieldDelimiter: ";", shouldParseNumbers: false, eol: '\n');
    return lines.map((line) => _parseLine(line)).toList();
  }

  CsvLibEntry _parseLine(List line) {
    try {
      print("trying to parse line: $line, size: ${line.length}");
      final name = line[0];
      final perUnitCount = parseDouble(line[1]).toInt();
      final unitName = line[2];
      final kcals = parseDouble(line[3]).toInt();
      final carbs = parseDouble(line[4]);
      final fats = parseDouble(line[5]);
      final proteins = parseDouble(line[6]);
      return CsvLibEntry(
          name,
          unitName,
          perUnitCount,
          kcals,
          carbs,
          fats,
          proteins
      );
    } on Exception catch(e) {
      print(e);
      throw e;
    }
  }

  int parseInt(String text) {
    return int.parse(text);
  }

  double parseDouble(String text) {
    final replaced = text.replaceAll(",", ".");
    return double.parse(replaced);
  }

}
