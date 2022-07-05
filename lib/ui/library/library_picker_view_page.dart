import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kcal_counter_flutter/core/library/model/csv_lib_entry.dart';
import 'package:kcal_counter_flutter/core/library/model/library_entry.dart';
import 'package:kcal_counter_flutter/ui/library/library_list_view.dart';
import 'package:kcal_counter_flutter/ui/library/library_view_tab.dart';
import 'package:kcal_counter_flutter/ui/library/paged_library_list_view.dart';
import 'package:kcal_counter_flutter/ui/libraryedit/library_edit_view.dart';
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
