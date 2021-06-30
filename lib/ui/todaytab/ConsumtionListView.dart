import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kcal_counter_flutter/core/history/model/Consumption.dart';
import 'package:kcal_counter_flutter/core/history/model/Day.dart';
import 'package:kcal_counter_flutter/ui/addconsumption/AddConsumptionView.dart';
import 'package:kcal_counter_flutter/ui/todaytab/ConsumptionListItemView.dart';

class ConsumptionListView extends StatelessWidget {
  final List<Consumption> consumptions;
  final ConsumptionListListener listener;

  const ConsumptionListView({Key? key, required this.consumptions, required this.listener})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.consumptions.isEmpty) {
      return _empty();
    }
    return _list(context);
  }

  Widget _empty() {
    return Center(child: Text("Brak elementów"));
  }

  Widget _list(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, position) => _item(context, position),
        itemCount: consumptions.length);
  }

  Widget _item(BuildContext context, int position) {
    final item = consumptions[position];
    return InkWell(
      onLongPress: () => listener.deleteConsumptionClicked(item),
        child: ConsumptionListItemView(key: ObjectKey(item), consumption: item));
  }

}

abstract class ConsumptionListListener {
  void consumptionClicked(Consumption consumption);
  void deleteConsumptionClicked(Consumption consumption);
}
