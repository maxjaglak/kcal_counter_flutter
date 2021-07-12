import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kcal_counter_flutter/core/history/model/Consumption.dart';

class ConsumptionListItemView extends StatelessWidget {
  final Consumption consumption;

  const ConsumptionListItemView({Key? key, required this.consumption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(consumption.name,
                style: Theme.of(context).textTheme.bodyText1),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(image: AssetImage("assets/images/scale.png")),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(consumption.amount.toString() + " " + consumption.calculationUnit,
                    style: Theme.of(context).textTheme.bodyText2),
              ),
              Image(image: AssetImage("assets/images/kcal.png")),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(consumption.kcals.toString() + " kcal",
                    style: Theme.of(context).textTheme.bodyText2),
              )
            ],
          ),
          Container(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(image: AssetImage("assets/images/carbs.png")),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(consumption.carbs.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.bodyText2),
              ),
              Image(image: AssetImage("assets/images/fat.png")),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(consumption.fat.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.bodyText2),
              ),
              Image(image: AssetImage("assets/images/protein.png")),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(consumption.protein.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.bodyText2),
              )
            ],
          ),
        ],
      ),
    );
  }
}
