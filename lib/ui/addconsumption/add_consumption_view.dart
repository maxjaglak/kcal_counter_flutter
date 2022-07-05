import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kcal_counter_flutter/core/history/consumption_service.dart';
import 'package:kcal_counter_flutter/core/history/model/day.dart';
import 'package:kcal_counter_flutter/core/kiwi/kiwi_injector.dart';
import 'package:kcal_counter_flutter/core/library/model/library_entry.dart';
import 'package:kcal_counter_flutter/ui/library/library_list_item.dart';
import 'package:kcal_counter_flutter/ui/library/library_picker_view_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddConsumptionViewPage extends StatelessWidget {
  final Day day;

  const AddConsumptionViewPage({Key? key, required this.day}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addConsumption),
      ),
      body: AddConsumptionView(day: day),
    );
  }
}

class AddConsumptionView extends StatefulWidget {
  final Day day;

  const AddConsumptionView({Key? key, required this.day}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AddConsumptionViewState();
}

class AddConsumptionViewState extends State<AddConsumptionView> {

  final ConsumptionService _consumptionService = KiwiInjector.instance.getContainer().resolve<ConsumptionService>();
  LibraryEntry? _pickedEntry;
  final TextEditingController _quantityController = TextEditingController();
  bool _shouldDisplaySaveButton = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    if (_pickedEntry != null) {
      widgets.add(LibraryListItemView(
          entry: _pickedEntry!, key: ObjectKey(_pickedEntry)));
    }
    if (_pickedEntry == null) {
      widgets.add(TextButton(onPressed: () => _pick(), child: Text(AppLocalizations.of(context)!.addFromList)));
    } else {
      widgets.add(Container(height:20));
      widgets.add(
          TextButton(onPressed: () => _removePick(), child: Text(AppLocalizations.of(context)!.change)));
    }

    if (_pickedEntry != null) {
      widgets.add(TextField(
          controller: _quantityController,
          onChanged: (number) => _numberChanged(number),
          keyboardType:
              TextInputType.numberWithOptions(signed: false, decimal: false)));

      final amountLabel = AppLocalizations.of(context)!.amount;
      widgets.add(Text("$amountLabel [${_pickedEntry!.unitName}]"));
    }

    if (_shouldDisplaySaveButton) {
      widgets.add(Container(height:20));
      widgets.add(TextButton(onPressed: () => _save(), child: Text(AppLocalizations.of(context)!.save)));
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: widgets),
    );
  }

  void _pick() async {
    LibraryEntry? libEntry = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LibraryPickerViewPage()));

    setState(() {
      if (libEntry != null) {
        _pickedEntry = libEntry;
      }
    });
  }

  _removePick() {
    setState(() {
      _pickedEntry = null;
    });
    _pick();
  }

  _numberChanged(String number) {
    setState(() {
      _shouldDisplaySaveButton = (int.tryParse(number) ?? 0) > 0 && _pickedEntry != null;
    });
  }

  _save() async {
    final quantity = int.tryParse(_quantityController.text.toString()) ?? 0;
    await _consumptionService.saveConsumption(widget.day, _pickedEntry!, quantity);

    Navigator.of(context).pop();
  }
}
