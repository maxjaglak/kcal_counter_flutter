import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'LibEntry.dart';

class LibraryRepository {

  Future<List<LibEntry>> getAll() async {
    final libraryDataCsv = await rootBundle.loadString("assets/table.csv");
    final List<List<dynamic>> lines = CsvToListConverter().convert(libraryDataCsv, fieldDelimiter: ";", shouldParseNumbers: false, eol: '\n');
    return lines.map((line) => _parseLine(line)).toList();
  }

  LibEntry _parseLine(List line) {
    print("trying to parse line: $line");
    final name = line[0];
    final kcals = parseDouble(line[1]).toInt();
    final proteins = parseDouble(line[2]);
    final carbs = parseDouble(line[3]);
    final fats = parseDouble(line[4]);
    return LibEntry(
      name,
      "gramy",
      100,
      kcals,
      carbs,
      fats,
      proteins
    );
  }

  int parseInt(String text) {
    return int.parse(text);
  }

  double parseDouble(String text) {
    final replaced = text.replaceAll(",", ".");
    return double.parse(replaced);
  }

}
