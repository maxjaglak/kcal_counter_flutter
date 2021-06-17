import 'package:flutter/cupertino.dart';
import 'package:kcal_counter_flutter/core/library/LibEntry.dart';
import 'package:kcal_counter_flutter/ui/commonwidget/SearchBarWidget.dart';
import 'package:kcal_counter_flutter/ui/library/LibraryListItem.dart';

class LibraryListView extends StatefulWidget {
  final List<LibEntry> entries;

  const LibraryListView({Key? key, required this.entries}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LibraryListViewState();

}

class LibraryListViewState extends State<LibraryListView> implements SearchBarListener {

  final List<LibEntry> filtered = [];
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
    return LibraryListItemView(entry: entry, key: ObjectKey(entry));
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
    final filtered = widget.entries.where((element) => element.containsQuery(query)).toList();
    setState(() {
      this.filtered.clear();
      this.filtered.addAll(filtered);
    });
  }


}
