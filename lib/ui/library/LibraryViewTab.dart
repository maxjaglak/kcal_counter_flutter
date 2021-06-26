import 'package:flutter/cupertino.dart';
import 'package:kcal_counter_flutter/core/library/model/LibraryEntry.dart';
import 'package:kcal_counter_flutter/ui/library/PagedLibraryListView.dart';
import 'LibraryListView.dart';

class LibraryViewTab extends StatelessWidget {

  const LibraryViewTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PagedLibraryListView(
      listener: TabListener(context),
    );
  }
}

class TabListener implements LibraryListListener {

  final BuildContext context;

  TabListener(this.context);

  @override
  void libEntryClicked(LibraryEntry libEntry) {
    // Navigator.of(context).pop(libEntry);
  }

}
