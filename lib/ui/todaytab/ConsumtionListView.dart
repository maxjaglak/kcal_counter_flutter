import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kcal_counter_flutter/core/history/model/Consumption.dart';
import 'package:kcal_counter_flutter/core/history/model/Day.dart';
import 'package:kcal_counter_flutter/ui/addconsumption/AddConsumptionView.dart';
import 'package:kcal_counter_flutter/ui/todaytab/ConsumptionListItemView.dart';

class ConsumptionListView extends StatelessWidget {
  final List<Consumption> consumptions;

  const ConsumptionListView({Key? key, required this.consumptions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.consumptions.isEmpty) {
      return _empty();
    }
    return _list();
  }

  Widget _empty() {
    return Center(child: Text("Brak elementów"));
  }

  Widget _list() {
    return ListView.builder(
        itemBuilder: (context, position) => _item(position),
        itemCount: consumptions.length);
  }

  Widget _item(int position) {
    final item = consumptions[position];
    return ConsumptionListItemView(key: ObjectKey(item), consumption: item);
  }

}
