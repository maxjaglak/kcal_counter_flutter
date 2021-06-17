import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kcal_counter_flutter/core/library/LibEntry.dart';
import 'package:kcal_counter_flutter/ui/library/LibraryListView.dart';
import 'package:kcal_counter_flutter/ui/library/LibraryView.dart';

class LibraryPickerViewPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Wybierz...")),
        body: LibraryViewCubit(listener: PickerListener(context)));
  }

}

class PickerListener implements LibraryListListener {

  final BuildContext context;

  PickerListener(this.context);

  @override
  void libEntryClicked(LibEntry libEntry) {
    Navigator.of(context).pop(libEntry);
  }

}