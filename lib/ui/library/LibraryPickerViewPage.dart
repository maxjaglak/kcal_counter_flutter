import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kcal_counter_flutter/core/library/model/CsvLibEntry.dart';
import 'package:kcal_counter_flutter/core/library/model/LibraryEntry.dart';
import 'package:kcal_counter_flutter/ui/library/LibraryListView.dart';
import 'package:kcal_counter_flutter/ui/library/LibraryViewTab.dart';
import 'package:kcal_counter_flutter/ui/library/PagedLibraryListView.dart';

class LibraryPickerViewPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Wybierz...")),
        body: PagedLibraryListView(listener: PickerListener(context)));
  }

}

class PickerListener implements LibraryListListener {

  final BuildContext context;

  PickerListener(this.context);

  @override
  void libEntryClicked(LibraryEntry libEntry) {
    Navigator.of(context).pop(libEntry);
  }

}