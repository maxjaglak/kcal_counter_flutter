import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:kcal_counter_flutter/core/kiwi/KiwiInjector.dart';
import 'package:kcal_counter_flutter/core/library/dao/LibraryEntryDao.dart';
import 'package:kcal_counter_flutter/core/library/model/CsvLibEntry.dart';
import 'package:kcal_counter_flutter/core/library/model/LibraryEntry.dart';
import 'package:kcal_counter_flutter/ui/commonwidget/SearchBarWidget.dart';
import 'package:kcal_counter_flutter/ui/library/LibraryListItem.dart';

import 'LibraryListView.dart';

class PagedLibraryListView extends StatefulWidget {
  final LibraryListListener? listener;

  PagedLibraryListView({Key? key, this.listener}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PagedLibraryListViewState();

}

class PagedLibraryListViewState extends State<PagedLibraryListView>
    implements SearchBarListener {
  late LibraryEntryDao _libraryEntryDao;
  SearchBarWidget? search = null;

  final int _pageSize = 100;
  final PagingController<int, LibraryEntry> _pagingController =
      PagingController<int, LibraryEntry>(firstPageKey: 0);

  String? _query = null;

  @override
  void initState() {
    super.initState();
    _libraryEntryDao =
        KiwiInjector.instance.getContainer().resolve<LibraryEntryDao>();

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    search = SearchBarWidget(listener: this);
  }

  void _fetchPage(int pageKey) async {
    try {
      final entries = await _getEntries(pageKey);
      if (entries.length < _pageSize) {
        _pagingController.appendLastPage(entries);
      } else {
        _pagingController.appendPage(entries, pageKey + 1);
      }
    } on Exception catch (e) {
      print(e);
      _pagingController.error = e;
    }
  }

  Future<List<LibraryEntry>> _getEntries(int pageKey) async {
    if(_query == null) {
      return await _libraryEntryDao.getPage(_pageSize, _pageSize * pageKey);
    } else {
      return await _libraryEntryDao.getPageWithQuery(_pageSize, _pageSize * pageKey, "%${_query!}%");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        search!,
        Expanded(
            child: PagedListView<int, LibraryEntry>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<LibraryEntry>(
                    itemBuilder: (context, item, index) =>
                        _listItem(context, item))))
      ],
    );
  }

  Widget _listItem(BuildContext context, LibraryEntry entry) {
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
    setState(() {
      _query = text.toLowerCase();
      _pagingController.refresh();
    });
  }

  _tap(LibraryEntry entry) {
    widget.listener?.libEntryClicked(entry);
  }

  void refresh() {
    this._pagingController.refresh();
  }

  void updateQuery(String name) {
    setState(() {
      _query = name.toLowerCase();
      _
      _pagingController.refresh();
    });
  }

}
