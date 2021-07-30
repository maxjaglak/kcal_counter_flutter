import 'package:flutter/cupertino.dart';
import 'package:kcal_counter_flutter/core/history/ConsumptionService.dart';
import 'package:kcal_counter_flutter/core/history/DateService.dart';
import 'package:kcal_counter_flutter/core/history/model/ConsumptionSummary.dart';
import 'package:kcal_counter_flutter/core/history/model/Day.dart';
import 'package:kcal_counter_flutter/core/kiwi/KiwiInjector.dart';
import 'package:kcal_counter_flutter/ui/todaytab/SummaryView.dart';
import 'package:kcal_counter_flutter/ui/tools/GeneralUI.dart';

class DaySummaryView extends StatelessWidget {
  final Day day;
  late ConsumptionService _consumptionService;

  final DateService _dateService = KiwiInjector.instance.getContainer().resolve<DateService>();

  DaySummaryView({Key? key, required this.day}) : super(key: key) {
    _consumptionService =
        KiwiInjector.instance.getContainer().resolve<ConsumptionService>();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snap) {
          if (!snap.hasData) return GeneralUI.progressIndicator();

          final consumptionSummary = snap.data as ConsumptionSummary;
          return SummaryView(
              consumptionSummary: consumptionSummary,
              key: ValueKey(_dateService.printDate(context, consumptionSummary.day)));
        },
        future: _consumptionService.getCosumptionSummaryForDay(day.id!));
  }

}
