import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kcal_counter_flutter/core/library/model/library_entry.dart';
import 'package:kcal_counter_flutter/ui/library/paged_library_list_view.dart';
import 'package:kcal_counter_flutter/ui/libraryedit/library_edit_view.dart';
import 'library_list_view.dart';

class LibraryViewTab extends StatelessWidget {

  LibraryViewTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PagedLibraryListView(
          listener: TabListener(context, pagedLibraryListViewGlobalKey),
          key: pagedLibraryListViewGlobalKey,
        ),
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
      ],
    );
  }

  _add(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LibraryEditViewPage(key: UniqueKey())));

    pagedLibraryListViewGlobalKey.currentState?.refresh();
  }
}

class TabListener implements LibraryListListener {
  final BuildContext context;
  final GlobalKey<PagedLibraryListViewState> libKey;

  TabListener(this.context, this.libKey);

  @override
  void libEntryClicked(LibraryEntry libEntry) async{
    await Navigator.of(this.context).push(MaterialPageRoute(
        builder: (context) => LibraryEditViewPage(
            libraryEntry: libEntry, key: ObjectKey(libEntry))));

    libKey.currentState?.refresh();
  }

}
