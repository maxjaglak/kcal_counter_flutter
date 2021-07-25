import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchBarWidget extends StatefulWidget {
  final SearchBarListener listener;

  SearchBarWidget({Key? key, required this.listener}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SearchBarWidgetState();
  }
}

class SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();

  bool _shouldDisplayClearButton = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                autofocus: false,
                autocorrect: false,
                controller: _controller,
                onChanged: (text) => _textChanged(text),
              ),
            )),
        _shouldDisplayClearButton
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => _clear(),
                ),
              )
            : Container(width: 0, height: 0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(Icons.search),
            onPressed: () => _searchPressed(),
          ),
        )
      ],
    );
  }

  void _textChanged(String text) {
    widget.listener.textChanged(text);
    setState(() {
      _shouldDisplayClearButton = text.length > 0;
    });
  }

  void _searchPressed() {
    final text = _controller.text.toString();
    widget.listener.searchClicked(text);
  }

  void _clear() {
    _controller.text = "";
    setState(() {
      _shouldDisplayClearButton = false;
    });
    widget.listener.textChanged("");
  }
}

abstract class SearchBarListener {
  void textChanged(String text);

  void searchClicked(String text);
}
