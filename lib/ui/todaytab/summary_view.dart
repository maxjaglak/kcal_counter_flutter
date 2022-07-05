import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kcal_counter_flutter/core/history/date_service.dart';
import 'package:kcal_counter_flutter/core/history/model/consumption_summary.dart';
import 'package:kcal_counter_flutter/core/kiwi/kiwi_injector.dart';
import 'package:kcal_counter_flutter/ui/tools/rounding_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SummaryView extends StatelessWidget {

  final ConsumptionSummary consumptionSummary;

  final RoundingHelper _roundingHelper = RoundingHelper();
  final DateService _dateService = KiwiInjector.instance.getContainer().resolve<DateService>();

  SummaryView({required this.consumptionSummary, required Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {

    final numberOfEntries = consumptionSummary.numberOfEntries;

    final totalCarbs = _roundingHelper.roundOneDecimalPlace(consumptionSummary.totalCarbs);
    final totalFats = _roundingHelper.roundOneDecimalPlace(consumptionSummary.totalFats);
    final totalProteins = _roundingHelper.roundOneDecimalPlace(consumptionSummary.totalProteins);


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_dateService.printDate(context, consumptionSummary.day), style: Theme.of(context).textTheme.headline3),
          Text(AppLocalizations.of(context)!.summaryKcalCount(consumptionSummary.totalKcals.toString()), style: Theme.of(context).textTheme.headline6),
          Text(AppLocalizations.of(context)!.summaryCarbsCount(totalCarbs)),
          Text(AppLocalizations.of(context)!.summaryFatCount(totalFats)),
          Text(AppLocalizations.of(context)!.summaryProteinCount(totalProteins)),
          Text(AppLocalizations.of(context)!.summaryItemsCount(numberOfEntries.toString())),
        ],
      ),
    );
  }



}