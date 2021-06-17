import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kcal_counter_flutter/core/history/ConsumptionService.dart';
import 'package:kcal_counter_flutter/core/history/model/Day.dart';
import 'package:kcal_counter_flutter/core/kiwi/KiwiInjector.dart';
import 'package:kcal_counter_flutter/core/library/LibEntry.dart';
import 'package:kcal_counter_flutter/ui/library/LibraryListItem.dart';
import 'package:kcal_counter_flutter/ui/library/LibraryPickerViewPage.dart';

class AddConsumptionViewPage extends StatelessWidget {
  final Day day;

  const AddConsumptionViewPage({Key? key, required this.day}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dodaj posiłek"),
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
  LibEntry? _pickedEntry;
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
      widgets.add(TextButton(onPressed: () => _pick(), child: Text("Dodaj")));
    } else {
      widgets.add(
          TextButton(onPressed: () => _removePick(), child: Text("Zmień")));
    }

    if (_pickedEntry != null) {
      widgets.add(TextField(
          controller: _quantityController,
          onChanged: (number) => _numberChanged(number),
          keyboardType:
              TextInputType.numberWithOptions(signed: false, decimal: false)));
    }

    if (_shouldDisplaySaveButton) {
      widgets.add(TextButton(onPressed: () => _save(), child: Text("Zapisz")));
    }

    return Column(children: widgets);
  }

  void _pick() async {
    LibEntry? libEntry = await Navigator.of(context)
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
