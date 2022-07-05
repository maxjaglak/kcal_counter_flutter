import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kcal_counter_flutter/core/library/model/csv_lib_entry.dart';
import 'package:kcal_counter_flutter/core/library/model/library_entry.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LibraryListItemView extends StatelessWidget {
  final LibraryEntry entry;

  const LibraryListItemView({Key? key, required this.entry}) : super(key: key);

  static const double imageSize = 24.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(entry.name,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(image: AssetImage("assets/images/scale.png"),
                  width: imageSize,
                  height: imageSize),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                    entry.perUnitCount.toString() + " " + entry.unitName,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2),
              ),
              Image(image: AssetImage("assets/images/kcal.png"),
                  width: imageSize,
                  height: imageSize),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(entry.kcals.toString() + " " +AppLocalizations.of(context)!.kcal,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2),
              )
            ],
          ),
          Container(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(image: AssetImage("assets/images/carbs.png"),
                  width: imageSize,
                  height: imageSize),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(entry.carbs.toStringAsFixed(2),
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2),
              ),
              Image(image: AssetImage("assets/images/fat.png"),
                  width: imageSize,
                  height: imageSize),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(entry.fat.toStringAsFixed(2),
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2),
              ),
              Image(image: AssetImage("assets/images/protein.png"),
                  width: imageSize,
                  height: imageSize),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(entry.protein.toStringAsFixed(2),
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2),
              )
            ],
          ),
        ],
      ),
    );
  }
}
