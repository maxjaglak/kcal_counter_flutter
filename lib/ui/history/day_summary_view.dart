import 'package:flutter/cupertino.dart';
import 'package:kcal_counter_flutter/core/history/consumption_service.dart';
import 'package:kcal_counter_flutter/core/history/date_service.dart';
import 'package:kcal_counter_flutter/core/history/model/consumption_summary.dart';
import 'package:kcal_counter_flutter/core/history/model/day.dart';
import 'package:kcal_counter_flutter/core/kiwi/kiwi_injector.dart';
import 'package:kcal_counter_flutter/ui/todaytab/summary_view.dart';
import 'package:kcal_counter_flutter/ui/tools/general_ui.dart';

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
          if (!snap.hasData) return Container();

          final consumptionSummary = snap.data as ConsumptionSummary;
          return SummaryView(
              consumptionSummary: consumptionSummary,
              key: ValueKey(_dateService.printDate(context, consumptionSummary.day)));
        },
        future: _consumptionService.getCosumptionSummaryForDay(day.id!));
  }

}
