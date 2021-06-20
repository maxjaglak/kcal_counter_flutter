import 'package:flutter/cupertino.dart';
import 'package:kcal_counter_flutter/core/history/model/ConsumptionSummary.dart';

class SummaryView extends StatelessWidget {

  final ConsumptionSummary consumptionSummary;

  SummaryView({required this.consumptionSummary, required Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(consumptionSummary.dayName),
          Text("Kalorie: ${consumptionSummary.totalKcals}"),
          Text("Węglowodany: ${consumptionSummary.totalCarbs}"),
          Text("Tłuszcze: ${consumptionSummary.totalFats}"),
          Text("Białko: ${consumptionSummary.totalProteins}"),
          Text("Ilość rzeczy: ${consumptionSummary.numberOfEntries}"),
        ],
      ),
    );
  }



}