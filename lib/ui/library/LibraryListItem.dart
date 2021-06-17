import 'package:flutter/cupertino.dart';
import 'package:kcal_counter_flutter/core/library/LibEntry.dart';

class LibraryListItemView extends StatelessWidget {

  final LibEntry entry;

  const LibraryListItemView({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(entry.toString(), key: ObjectKey(entry)),
    );
  }

}