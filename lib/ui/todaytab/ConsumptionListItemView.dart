import 'package:flutter/cupertino.dart';
import 'package:kcal_counter_flutter/core/history/model/Consumption.dart';

class ConsumptionListItemView extends StatelessWidget {
  final Consumption consumption;

  const ConsumptionListItemView({Key? key, required this.consumption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: (
        Text(consumption.toString())
      ),
    );
  }
}
