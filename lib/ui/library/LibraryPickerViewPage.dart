import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kcal_counter_flutter/core/library/model/CsvLibEntry.dart';
import 'package:kcal_counter_flutter/core/library/model/LibraryEntry.dart';
import 'package:kcal_counter_flutter/ui/library/LibraryListView.dart';
import 'package:kcal_counter_flutter/ui/library/LibraryViewTab.dart';
import 'package:kcal_counter_flutter/ui/library/PagedLibraryListView.dart';
import 'package:kcal_counter_flutter/ui/libraryedit/LibraryEditView.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LibraryPickerViewPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.chooseDots)),
        body: Stack(children: [
          PagedLibraryListView(listener: PickerListener(context), key: pagedLibraryListViewGlobalKey),
          Positioned(
              bottom: 10,
              right: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () => _add(context),
                ),
              ))
        ]));
  }

  _add(BuildContext context) async {
    final LibraryEntry libraryEntry = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LibraryEditViewPage(key: UniqueKey())));

    pagedLibraryListViewGlobalKey.currentState?.updateQuery(libraryEntry.name);
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
