import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kcal_counter_flutter/core/library/model/csv_lib_entry.dart';
import 'package:kcal_counter_flutter/core/library/model/library_entry.dart';
import 'package:kcal_counter_flutter/ui/commonwidget/search_bar_widget.dart';
import 'package:kcal_counter_flutter/ui/library/library_list_item.dart';

class LibraryListView extends StatefulWidget {
  final List<LibraryEntry> entries;
  final LibraryListListener? listener;

  const LibraryListView({Key? key, required this.entries, this.listener})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => LibraryListViewState();
}

class LibraryListViewState extends State<LibraryListView>
    implements SearchBarListener {
  final List<LibraryEntry> filtered = [];
  SearchBarWidget? search = null;

  @override
  void initState() {
    super.initState();
    filtered.addAll(widget.entries);
    search = SearchBarWidget(listener: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        search!,
        Expanded(
          child: ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, position) => _listItem(context, position),
            physics: BouncingScrollPhysics(),
          ),
        ),
      ],
    );
  }

  Widget _listItem(BuildContext context, int position) {
    var entry = filtered[position];
    return InkWell(
        onTap: () => _tap(entry),
        child: LibraryListItemView(entry: entry, key: ObjectKey(entry)));
  }

  @override
  void searchClicked(String text) {
    _filter(text);
  }

  @override
  void textChanged(String text) {
    _filter(text);
  }

  void _filter(String text) {
    final query = text.toLowerCase().split(" ").toList();
    final filtered = widget.entries
        .where((element) => element.containsQuery(query))
        .toList();
    setState(() {
      this.filtered.clear();
      this.filtered.addAll(filtered);
    });
  }

  _tap(LibraryEntry entry) {
    widget.listener?.libEntryClicked(entry);
  }
}

abstract class LibraryListListener {
  void libEntryClicked(LibraryEntry libEntry);
}
